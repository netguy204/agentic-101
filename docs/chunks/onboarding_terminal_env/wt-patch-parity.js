#!/usr/bin/env node
// Chunk artifact: verifies the JSON logic in env/windows/Patch-WindowsTerminal.ps1.
//
// The implementing machine was macOS with no PowerShell, so the PowerShell
// script itself could not be executed. This file transcribes its two algorithms
// — the JSONC noise scanner and the settings transformation — statement by
// statement into Node, and asserts their behaviour against fixtures that look
// like real Windows Terminal settings files.
//
// What this proves: the algorithm handles comments, `//` inside string values,
// trailing commas, pre-existing conflicting bindings, and repeat runs.
// What this does NOT prove: that the PowerShell transcription is faithful, that
// the winget/path code works, or that Windows Terminal accepts the result.
// Those need a Windows machine — see env/README.md and env/FLOOR_TEST.md.
//
// Run: node docs/chunks/onboarding_terminal_env/wt-patch-parity.js

'use strict';

const PROFILE_GUID = '{5f1b98b3-9d4c-4b0f-9a1e-6d2c7a8e4f11}';
const TAG = 'agentic-101:';
const ESC = '\u001b';
const PI_CHORDS = ['shift+enter', 'alt+enter'];

// --- transcription of Remove-JsonNoise -------------------------------------

function removeJsonNoise(text) {
    let out = '';
    let inString = false;
    let escaped = false;
    let i = 0;
    while (i < text.length) {
        const c = text[i];
        if (inString) {
            out += c;
            if (escaped) escaped = false;
            else if (c === '\\') escaped = true;
            else if (c === '"') inString = false;
            i++;
            continue;
        }
        if (c === '"') { inString = true; out += c; i++; continue; }
        if (c === '/' && i + 1 < text.length) {
            const next = text[i + 1];
            if (next === '/') {
                while (i < text.length && text[i] !== '\n') i++;
                continue;
            }
            if (next === '*') {
                i += 2;
                while (i + 1 < text.length && !(text[i] === '*' && text[i + 1] === '/')) i++;
                i += 2;
                continue;
            }
        }
        out += c;
        i++;
    }

    const text2 = out;
    let out2 = '';
    inString = false;
    escaped = false;
    for (let j = 0; j < text2.length; j++) {
        const c = text2[j];
        if (inString) {
            out2 += c;
            if (escaped) escaped = false;
            else if (c === '\\') escaped = true;
            else if (c === '"') inString = false;
            continue;
        }
        if (c === '"') { inString = true; out2 += c; continue; }
        if (c === ',') {
            let k = j + 1;
            while (k < text2.length && /\s/.test(text2[k])) k++;
            if (k < text2.length && (text2[k] === '}' || text2[k] === ']')) continue;
        }
        out2 += c;
    }
    return out2;
}

// --- transcription of the settings transformation --------------------------

function boundToChord(entry) {
    if (!entry || typeof entry !== 'object') return false;
    if (!Object.prototype.hasOwnProperty.call(entry, 'keys')) return false;
    const keys = entry.keys;
    if (keys === null || keys === undefined) return false;
    for (const k of [].concat(keys)) {
        if (PI_CHORDS.indexOf(String(k).replace(/\s/g, '').toLowerCase()) !== -1) return true;
    }
    return false;
}

function patch(json, gitBash) {
    if (!Object.prototype.hasOwnProperty.call(json, 'actions')) json.actions = [];
    const kept = [].concat(json.actions).filter((a) => !boundToChord(a));
    json.actions = kept.concat([
        {
            name: `${TAG} pi newline (Shift+Enter)`,
            keys: 'shift+enter',
            command: { action: 'sendInput', input: `${ESC}[13;2u` },
        },
        {
            name: `${TAG} pi follow-up (Alt+Enter)`,
            keys: 'alt+enter',
            command: { action: 'sendInput', input: `${ESC}[13;3u` },
        },
    ]);

    if (Object.prototype.hasOwnProperty.call(json, 'keybindings')) {
        json.keybindings = [].concat(json.keybindings).filter((k) => !boundToChord(k));
    }

    if (!Object.prototype.hasOwnProperty.call(json, 'profiles')) json.profiles = {};
    if (Array.isArray(json.profiles)) json.profiles = { list: json.profiles };
    if (!Object.prototype.hasOwnProperty.call(json.profiles, 'list')) json.profiles.list = [];

    const gitBashProfile = {
        guid: PROFILE_GUID,
        name: 'Git Bash',
        commandline: `"${gitBash}" -i -l`,
        startingDirectory: '%USERPROFILE%',
        hidden: false,
    };
    const keptProfiles = [].concat(json.profiles.list).filter(
        (p) => p && !(Object.prototype.hasOwnProperty.call(p, 'guid') && p.guid === PROFILE_GUID)
    );
    json.profiles.list = keptProfiles.concat([gitBashProfile]);
    json.defaultProfile = PROFILE_GUID;
    return json;
}

// --- fixtures ---------------------------------------------------------------

const GIT_BASH = 'C:\\Program Files\\Git\\bin\\bash.exe';

const FIXTURE_TYPICAL = `
{
    // This file was initially generated by Windows Terminal 1.24
    // Comments are OK in this file.
    "$help": "https://aka.ms/terminal-documentation",
    "$schema": "https://aka.ms/terminal-profiles-schema",
    "defaultProfile": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
    /* a block comment
       spanning lines */
    "profiles": {
        "defaults": {},
        "list": [
            {
                "commandline": "%SystemRoot%\\\\System32\\\\WindowsPowerShell\\\\v1.0\\\\powershell.exe",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "name": "Windows PowerShell",
                "startingDirectory": "https://example.com//not-a-comment",
            },
        ],
    },
    "actions": [
        { "command": "paste", "keys": "ctrl+v" },
        { "command": "toggleFullscreen", "keys": "alt+enter" },
    ],
    "keybindings": [
        { "command": "closeWindow", "keys": "alt+f4" },
        { "command": "unbound", "keys": ["shift+enter", "ctrl+m"] }
    ]
}
`;

const FIXTURE_EMPTY = '{}';

const FIXTURE_PROFILES_ARRAY = `{
    "profiles": [ { "guid": "{aaaa}", "name": "Legacy" } ]
}`;

// --- assertions -------------------------------------------------------------

let pass = 0;
let fail = 0;
function check(desc, cond, detail) {
    if (cond) { pass++; console.log(`  PASS  ${desc}`); }
    else { fail++; console.log(`  FAIL  ${desc}${detail ? ` — ${detail}` : ''}`); }
}

console.log('== JSONC scanner ==');
const cleaned = removeJsonNoise(FIXTURE_TYPICAL);
let parsed;
try {
    parsed = JSON.parse(cleaned);
    check('a realistic settings.json with comments and trailing commas parses', true);
} catch (e) {
    check('a realistic settings.json with comments and trailing commas parses', false, e.message);
    process.exit(1);
}
check(
    '"//" inside a string value is not treated as a comment',
    parsed.profiles.list[0].startingDirectory === 'https://example.com//not-a-comment',
    parsed.profiles.list[0].startingDirectory
);
check('line comments are gone', cleaned.indexOf('initially generated') === -1);
check('block comments are gone', cleaned.indexOf('spanning lines') === -1);
check('backslash escapes survive',
    parsed.profiles.list[0].commandline.indexOf('\\System32\\') !== -1,
    parsed.profiles.list[0].commandline);

console.log('== transformation ==');
const patched = patch(parsed, GIT_BASH);

check('default profile is the course Git Bash profile', patched.defaultProfile === PROFILE_GUID);

const ours = patched.actions.filter((a) => a.name && a.name.indexOf(TAG) === 0);
check('exactly two tagged actions are added', ours.length === 2, JSON.stringify(ours.map((a) => a.keys)));
const shift = ours.find((a) => a.keys === 'shift+enter');
const alt = ours.find((a) => a.keys === 'alt+enter');
check('Shift+Enter sends the CSI-u sequence pi documents',
    shift && shift.command.action === 'sendInput' && shift.command.input === '\u001b[13;2u',
    shift && JSON.stringify(shift.command));
check('Alt+Enter sends the CSI-u sequence pi documents',
    alt && alt.command.action === 'sendInput' && alt.command.input === '\u001b[13;3u',
    alt && JSON.stringify(alt.command));
check("Windows Terminal's own alt+enter fullscreen binding is removed",
    !patched.actions.some((a) => a.command === 'toggleFullscreen'));
check('unrelated actions are left alone',
    patched.actions.some((a) => a.command === 'paste' && a.keys === 'ctrl+v'));
check('a legacy keybindings entry claiming shift+enter is removed',
    !patched.keybindings.some((k) => [].concat(k.keys).indexOf('shift+enter') !== -1));
check('unrelated legacy keybindings are left alone',
    patched.keybindings.some((k) => k.keys === 'alt+f4'));

const gb = patched.profiles.list.filter((p) => p.guid === PROFILE_GUID);
check('exactly one Git Bash profile', gb.length === 1);
check('Git Bash profile quotes the path and logs in',
    gb[0].commandline === '"C:\\Program Files\\Git\\bin\\bash.exe" -i -l', gb[0].commandline);
check('Git Bash profile starts in the home folder', gb[0].startingDirectory === '%USERPROFILE%');
check('the existing PowerShell profile survives',
    patched.profiles.list.some((p) => p.name === 'Windows PowerShell'));

console.log('== idempotency ==');
const first = JSON.stringify(patched);
const second = JSON.stringify(patch(JSON.parse(removeJsonNoise(first)), GIT_BASH));
check('running the patch twice produces the same file', first === second);

console.log('== edge cases ==');
const emptyPatched = patch(JSON.parse(removeJsonNoise(FIXTURE_EMPTY)), GIT_BASH);
check('an empty settings.json gets a full, valid result',
    emptyPatched.defaultProfile === PROFILE_GUID &&
    emptyPatched.actions.length === 2 &&
    emptyPatched.profiles.list.length === 1);

const arrayPatched = patch(JSON.parse(removeJsonNoise(FIXTURE_PROFILES_ARRAY)), GIT_BASH);
check('an old-schema profiles array is wrapped into { list: [...] }',
    Array.isArray(arrayPatched.profiles.list) &&
    arrayPatched.profiles.list.length === 2 &&
    arrayPatched.profiles.list[0].name === 'Legacy');

console.log('');
console.log(`RESULT: ${pass} passed, ${fail} failed`);
process.exit(fail === 0 ? 0 : 1);
