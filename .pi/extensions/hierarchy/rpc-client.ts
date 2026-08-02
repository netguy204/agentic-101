/**
 * Minimal RPC client for a long-lived `pi --mode rpc` subprocess.
 *
 * Protocol: strict LF-delimited JSONL over stdin/stdout (see pi docs/rpc.md).
 * We deliberately do NOT use node:readline — it splits on U+2028/U+2029,
 * which are valid inside JSON strings and break the protocol.
 *
 * This client is intentionally small: it exposes the handful of commands
 * the hierarchy extension needs and gives access to the raw event stream
 * so callers can observe subagent progress turn-by-turn.
 */

import { spawn, type ChildProcess } from "node:child_process";
import { EventEmitter } from "node:events";
import * as fs from "node:fs";
import * as path from "node:path";

/** A command we can send to the RPC process. Always gets a correlation id. */
export interface RpcCommand {
  type: string;
  [k: string]: unknown;
}

export interface RpcResponse {
  type: "response";
  id?: string;
  command: string;
  success: boolean;
  data?: unknown;
  error?: string;
}

/** Any event streamed from the RPC process. We keep it loosely typed. */
export type RpcEvent = Record<string, any> & { type: string };

export interface RpcClientOptions {
  /** Extra argv appended after `pi --mode rpc`. */
  extraArgs?: string[];
  /** Working directory for the subprocess. */
  cwd?: string;
  /** Pi binary or node entry to invoke. Defaults to resolving `pi`. */
  command?: string;
  commandArgs?: string[];
  /** Called when the process exits. */
  onExit?: (code: number | null) => void;
  /**
   * How long to wait for the child to become ready before `start()` rejects.
   * Readiness is proven by a successful `get_state` request/response round-trip
   * (the pi RPC protocol emits no explicit "ready" event, so we handshake on a
   * command we know the child can answer). Default 30s. 0 = wait forever.
   */
  readyTimeoutMs?: number;
  /** Default per-command timeout for `send()` when not overridden. 0 = wait forever. */
  defaultCommandTimeoutMs?: number;
}

interface PendingRequest {
  resolve: (resp: RpcResponse) => void;
  reject: (err: Error) => void;
  timer?: ReturnType<typeof setTimeout>;
}

/**
 * A typed wrapper around a single long-lived `pi --mode rpc` process.
 *
 * Lifecycle:
 *   const c = new RpcClient({...});
 *   await c.start();
 *   c.events.on("turn_end", (e) => ...);
 *   await c.prompt("do something");
 *   await c.steer("actually, do X first");
 *   await c.dispose();
 */
export class RpcClient extends EventEmitter {
  private proc: ChildProcess | null = null;
  private buffer = "";
  private stderrBuffer = "";
  private pending = new Map<string, PendingRequest>();
  private nextId = 1;
  private disposed = false;
  private exitCode: number | null = null;

  constructor(private opts: RpcClientOptions) {
    super();
  }

  /**
   * Spawn the subprocess and wait until it is ready.
   *
   * Resolves only once the JSONL channel is proven up — by a successful
   * `get_state` request/response round-trip. The pi RPC protocol emits no
   * explicit "ready" event, so sending a prompt before this point races the
   * child's startup: the prompt can be written to stdin before the child is
   * listening, or lost. Callers must `await start()` before sending commands.
   *
   * Rejects if the process exits, errors, or fails to answer `get_state`
   * within `readyTimeoutMs` (default 30s).
   */
  async start(): Promise<void> {
    const { command, commandArgs } = resolvePiInvocation(this.opts.command, this.opts.commandArgs);
    const args = [...(commandArgs ?? []), "--mode", "rpc", "--no-session", ...(this.opts.extraArgs ?? [])];

    this.proc = spawn(command, args, {
      cwd: this.opts.cwd ?? process.cwd(),
      shell: false,
      stdio: ["pipe", "pipe", "pipe"],
    });

    this.proc.stdout?.setEncoding("utf8");
    this.proc.stderr?.setEncoding("utf8");

    this.proc.stdout?.on("data", (chunk: string) => this.onStdout(chunk));
    this.proc.stderr?.on("data", (chunk: string) => {
      this.stderrBuffer += chunk;
      // Keep stderr from growing unbounded.
      if (this.stderrBuffer.length > 64 * 1024) this.stderrBuffer = this.stderrBuffer.slice(-32 * 1024);
    });

    this.proc.on("error", (err) => {
      this.emit("error", err);
    });
    this.proc.on("exit", (code) => {
      this.exitCode = code;
      // Reject any pending requests.
      for (const pending of this.pending.values()) {
        pending.reject(new Error(`RPC process exited (code ${code})`));
      }
      this.pending.clear();
      this.opts.onExit?.(code);
      this.emit("exit", code);
    });

    // Handshake: prove the channel is up before anyone sends a prompt.
    // get_state is a safe, cheap command the child can always answer.
    const readyTimeoutMs = this.opts.readyTimeoutMs ?? 30000;
    let readyTimer: ReturnType<typeof setTimeout> | undefined;
    try {
      await new Promise<void>((resolve, reject) => {
        const fail = (err: Error) => {
          if (readyTimer) clearTimeout(readyTimer);
          this.off("exit", onExit);
          this.off("error", onError);
          reject(err);
        };
        const onExit = (code: number | null) =>
          fail(
            new Error(
              `RPC process exited during startup (code ${code})` +
                (this.stderrBuffer.trim() ? `
--- child stderr ---
${this.stderrBuffer.trim().slice(-2048)}` : "") +
                `
(If stderr is empty and code is 0, the child exited silently — ` +
                `check that 'pi --mode rpc' works on its own in this environment, ` +
                `and that PI_PROVIDER/PI_MODEL or --model resolve to a working provider.)`,
            ),
          );
        const onError = (err: Error) =>
          fail(new Error(`RPC process errored during startup: ${err.message}`));
        this.on("exit", onExit);
        this.on("error", onError);
        if (readyTimeoutMs > 0) {
          readyTimer = setTimeout(
            () => fail(new Error(`RPC child did not become ready within ${readyTimeoutMs}ms`)),
            readyTimeoutMs,
          );
        }
        // A successful get_state round-trip proves stdin/stdout are wired.
        this.getState()
          .then(() => {
            if (readyTimer) clearTimeout(readyTimer);
            this.off("exit", onExit);
            this.off("error", onError);
            resolve();
          })
          .catch((err) => fail(err instanceof Error ? err : new Error(String(err))));
      });
    } catch (err) {
      // Clean up the half-started process so callers can treat start() failure as terminal.
      try {
        this.proc?.kill("SIGKILL");
      } catch {
        /* ignore */
      }
      throw err;
    }
  }

  private onStdout(chunk: string): void {
    this.buffer += chunk;
    // Split on LF only. Keep the trailing partial line in the buffer.
    let nl: number;
    while ((nl = this.buffer.indexOf("\n")) !== -1) {
      let line = this.buffer.slice(0, nl);
      this.buffer = this.buffer.slice(nl + 1);
      // Tolerate CRLF from the client side per the spec.
      if (line.endsWith("\r")) line = line.slice(0, -1);
      if (!line) continue;
      let msg: any;
      try {
        msg = JSON.parse(line);
      } catch {
        // Ignore malformed lines; protocol guarantees JSONL.
        continue;
      }
      this.dispatch(msg);
    }
  }

  private dispatch(msg: any): void {
    if (!msg || typeof msg !== "object") return;
    if (msg.type === "response" && typeof msg.id === "string") {
      const pending = this.pending.get(msg.id);
      if (pending) {
        this.pending.delete(msg.id);
        if (pending.timer) clearTimeout(pending.timer);
        const resp = msg as RpcResponse;
        if (resp.success) pending.resolve(resp);
        else pending.reject(new Error(resp.error ?? `RPC command '${resp.command}' failed`));
      }
      return;
    }
    // Everything else is an event. Emit by type and as a generic "event".
    this.emit(msg.type as string, msg as RpcEvent);
    this.emit("event", msg as RpcEvent);
  }

  /**
   * Send a command and await its response. Rejects on failure or timeout.
   * `timeoutMs` overrides the client's `defaultCommandTimeoutMs`; 0 = wait
   * forever (the historic default, kept for the prompt path where the parent
   * observes via turn_end rather than awaiting the response).
   */
  send(command: RpcCommand, timeoutMs?: number): Promise<RpcResponse> {
    const effectiveTimeout = timeoutMs ?? this.opts.defaultCommandTimeoutMs ?? 0;
    if (!this.proc || this.proc.killed || this.exitCode !== null) {
      return Promise.reject(new Error("RPC client is not running"));
    }
    const id = `req-${this.nextId++}`;
    const payload = JSON.stringify({ id, ...command }) + "\n";
    return new Promise<RpcResponse>((resolve, reject) => {
      const pending: PendingRequest = { resolve, reject };
      if (effectiveTimeout > 0) {
        pending.timer = setTimeout(() => {
          this.pending.delete(id);
          reject(new Error(`RPC command '${command.type}' timed out after ${effectiveTimeout}ms`));
        }, effectiveTimeout);
      }
      this.pending.set(id, pending);
      this.proc!.stdin!.write(payload, (err) => {
        if (err) {
          this.pending.delete(id);
          if (pending.timer) clearTimeout(pending.timer);
          reject(new Error(`Failed to write to RPC stdin: ${err.message}`));
        }
      });
    });
  }

  /** Fire-and-forget send for commands whose response we don't care about. */
  sendNoWait(command: RpcCommand): void {
    if (!this.proc || this.proc.killed || this.exitCode !== null) return;
    this.proc.stdin!.write(JSON.stringify(command) + "\n");
  }

  // --- Convenience wrappers for the commands we use ---

  prompt(message: string, streamingBehavior?: "steer" | "followUp"): Promise<RpcResponse> {
    const cmd: RpcCommand = { type: "prompt", message };
    if (streamingBehavior) cmd.streamingBehavior = streamingBehavior;
    return this.send(cmd);
  }

  steer(message: string): Promise<RpcResponse> {
    return this.send({ type: "steer", message });
  }

  followUp(message: string): Promise<RpcResponse> {
    return this.send({ type: "follow_up", message });
  }

  abort(): Promise<RpcResponse> {
    return this.send({ type: "abort" });
  }

  getLastAssistantText(): Promise<string | null> {
    return this.send({ type: "get_last_assistant_text" }).then((r) => (r.data as any)?.text ?? null);
  }

  /** Get session entries strictly after `since`, or all if omitted. */
  getEntries(since?: string): Promise<{ entries: any[]; leafId: string | null }> {
    const cmd: RpcCommand = { type: "get_entries" };
    if (since) cmd.since = since;
    return this.send(cmd).then((r) => r.data as { entries: any[]; leafId: string | null });
  }

  getState(): Promise<any> {
    return this.send({ type: "get_state" }).then((r) => r.data);
  }

  /** Stderr captured so far (for diagnostics on crash). */
  getStderr(): string {
    return this.stderrBuffer;
  }

  /** Terminate the subprocess gracefully, then forcibly after a grace period. */
  async dispose(): Promise<void> {
    if (this.disposed) return;
    this.disposed = true;
    const proc = this.proc;
    if (!proc) return;
    if (this.exitCode !== null) return;
    await new Promise<void>((resolve) => {
      let settled = false;
      const finish = () => {
        if (!settled) {
          settled = true;
          resolve();
        }
      };
      proc.once("exit", finish);
      try {
        proc.stdin?.end();
      } catch {
        /* ignore */
      }
      proc.kill("SIGTERM");
      setTimeout(() => {
        if (!settled) {
          try {
            proc.kill("SIGKILL");
          } catch {
            /* ignore */
          }
          finish();
        }
      }, 3000);
    });
  }

  get running(): boolean {
    return !!this.proc && !this.proc.killed && this.exitCode === null;
  }

  get exitInfo(): number | null {
    return this.exitCode;
  }
}

/**
 * Decide how to invoke a `pi --mode rpc` child.
 *
 * IMPORTANT: we must invoke pi's CLI *launcher*, not its library entry. The
 * package's `main` (`dist/index.js`) does not self-bootstrap RPC mode — when
 * spawned as `node dist/index.js --mode rpc` it exits silently with code 0
 * within ~300ms, no output, which is the exact failure that pinned the parent
 * overnight (the subagent showed 0 turns forever). The package's `bin`
 * (`dist/cli.js`, surfaced on PATH as `pi`) is the launcher that works: it
 * stays alive and answers RPC commands over piped stdio.
 *
 * So we prefer the `pi` launcher on PATH, resolving through the symlink to the
 * real file and invoking it with the current runtime (node) so a dev checkout
 * using a local node works without relying on the shebang. We only fall back to
 * re-invoking `process.argv[1]` when `pi` is not on PATH, and even then only if
 * that script is the launcher (basename `pi` or `cli.js`) — never `index.js`,
 * which is the file that exits.
 */
function resolvePiInvocation(command?: string, commandArgs?: string[]): {
  command: string;
  commandArgs?: string[];
} {
  if (command) return { command, commandArgs };

  const isBunVirtual = process.argv[1]?.startsWith("/$bunfs/root/");
  const currentScript = isBunVirtual ? undefined : process.argv[1];
  const currentBasename = currentScript ? path.basename(currentScript).toLowerCase() : "";
  // The launcher is `pi` / `cli.js` / `cli.mjs`. `index.js` is the library entry
  // that does NOT bootstrap RPC and exits silently — exclude it explicitly.
  const currentScriptIsLauncher =
    !!currentScript &&
    fs.existsSync(currentScript) &&
    (currentBasename === "pi" || currentBasename === "cli.js" || currentBasename === "cli.mjs");

  // Prefer the `pi` launcher on PATH. Resolve it to the real file behind the
  // symlink so we invoke a concrete path (and so `spawn` without `shell:true`
  // works even where the shebang wouldn't be honored).
  const piOnPath = which("pi");
  if (piOnPath) {
    let resolved = piOnPath;
    try {
      resolved = fs.realpathSync(piOnPath);
    } catch {
      /* keep the symlink path */
    }
    return { command: process.execPath, commandArgs: [resolved] };
  }

  // `pi` not on PATH: fall back to the current script only if it's the launcher.
  if (currentScriptIsLauncher) {
    return { command: process.execPath, commandArgs: [currentScript!] };
  }

  // Non-generic runtime (not node/bun): assume it can exec `pi` directly.
  const execName = path.basename(process.execPath).toLowerCase();
  const isGenericRuntime = /^(node|bun)(\.exe)?$/.test(execName);
  if (!isGenericRuntime) {
    return { command: process.execPath, commandArgs: [] };
  }

  // Last resort: try `pi` as a bare command (relies on PATH + shebang).
  return { command: "pi", commandArgs: [] };
}

/** Minimal `which` — find an executable on PATH. Returns absolute path or "". */
function which(bin: string): string {
  const pathVar = process.env.PATH;
  if (!pathVar) return "";
  const exts = process.platform === "win32" ? (process.env.PATHEXT ?? ".EXE").split(";") : [""];
  for (const dir of pathVar.split(path.delimiter)) {
    if (!dir) continue;
    for (const ext of exts) {
      const candidate = path.join(dir, bin + ext);
      try {
        if (fs.statSync(candidate).isFile()) return candidate;
      } catch {
        /* not present */
      }
    }
  }
  return "";
}
