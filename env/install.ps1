<#
.SYNOPSIS
    Install the agentic-101 course environment on Windows.

.DESCRIPTION
    Chunk: docs/chunks/onboarding_terminal_env - Windows installer

    Run this in PowerShell (Start menu -> type "PowerShell" -> Enter):

        irm <base-url>/install.ps1 | iex

    or, from a checkout of this repository:

        powershell -ExecutionPolicy Bypass -File .\env\install.ps1

    What it does, in order:

      1. Installs Git for Windows, Node.js LTS and Windows Terminal with
         winget, honouring the pins in versions.env.
      2. Patches Windows Terminal: pi's Shift+Enter and Alt+Enter bindings,
         and Git Bash as the default profile (DEC-007).
      3. Hands over to install.sh inside Git Bash, which installs the commit
         and revert commands and configures the shell. That is the same script
         macOS runs, so both platforms get an identical command set.

    Nothing here asks the participant a question, and re-running it is safe.

    AUTHORED BUT NOT EXECUTED ON WINDOWS — see env/README.md.

.PARAMETER SkipPackages
    Do not install anything with winget; only configure.

.PARAMETER DryRun
    Say what would happen and change nothing.
#>
[CmdletBinding()]
param(
    [switch]$SkipPackages,
    [switch]$DryRun
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$BaseUrlDefault = 'https://raw.githubusercontent.com/netguy204/agentic-101/main/env'
$BaseUrl = if ($env:AGENTIC101_ENV_BASE_URL) { $env:AGENTIC101_ENV_BASE_URL } else { $BaseUrlDefault }

function Write-Step { param([string]$Text) Write-Host ''; Write-Host $Text -ForegroundColor Cyan }
function Write-Ok   { param([string]$Text) Write-Host "  $Text" -ForegroundColor Green }
function Write-Note { param([string]$Text) Write-Host "  $Text" -ForegroundColor DarkGray }
function Write-Warn { param([string]$Text) Write-Host "  $Text" -ForegroundColor Yellow }

# The Windows Terminal patch below runs as a .ps1 file, which the default
# Restricted execution policy blocks even when this script itself arrived
# via `irm | iex` (piped content is exempt; files are not). Process scope
# lasts only for this session and needs no admin rights.
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
} catch {
    Write-Warn "could not relax the execution policy for this session: $_"
}

function Get-SourceDir {
    # The directory this script lives in, when it was run as a file. Empty when
    # it arrived through `irm | iex`, in which case we work from the network.
    if ($PSScriptRoot) { return $PSScriptRoot }
    if ($PSCommandPath) { return (Split-Path -Parent $PSCommandPath) }
    return $null
}

function ConvertTo-BashPath {
    param([Parameter(Mandatory = $true)][string]$Path)
    $full = [System.IO.Path]::GetFullPath($Path)
    $drive = $full.Substring(0, 1).ToLowerInvariant()
    $rest = $full.Substring(2) -replace '\\', '/'
    return "/$drive$rest"
}

function Read-VersionPins {
    param([string]$SourceDir)
    $pins = @{}
    $text = $null
    if ($SourceDir -and (Test-Path -LiteralPath (Join-Path $SourceDir 'versions.env'))) {
        $text = Get-Content -LiteralPath (Join-Path $SourceDir 'versions.env') -Raw
    } else {
        try { $text = (Invoke-WebRequest -UseBasicParsing -Uri "$BaseUrl/versions.env").Content } catch { $text = $null }
    }
    if (-not $text) { return $pins }
    foreach ($line in ($text -split "`n")) {
        $trimmed = $line.Trim()
        if ($trimmed -eq '' -or $trimmed.StartsWith('#')) { continue }
        $eq = $trimmed.IndexOf('=')
        if ($eq -lt 1) { continue }
        $pins[$trimmed.Substring(0, $eq).Trim()] = $trimmed.Substring($eq + 1).Trim()
    }
    return $pins
}

function Install-WingetPackage {
    param(
        [Parameter(Mandatory = $true)][string]$Id,
        [Parameter(Mandatory = $true)][string]$Label,
        [string]$Version
    )
    $wingetArgs = @(
        'install', '--id', $Id, '--exact', '--silent',
        '--accept-package-agreements', '--accept-source-agreements',
        '--disable-interactivity'
    )
    if ($Version) { $wingetArgs += @('--version', $Version) }

    if ($DryRun) { Write-Note "would run: winget $($wingetArgs -join ' ')"; return }

    Write-Note "installing $Label…"
    & winget @wingetArgs
    # winget exits non-zero when a package is already current; that is success
    # for our purposes, and we verify the outcome afterwards regardless.
    if ($LASTEXITCODE -ne 0) {
        Write-Warn "$Label : winget exited with $LASTEXITCODE (this is normal when it is already installed)"
    }
}

# --- preflight -------------------------------------------------------------

if ($env:OS -ne 'Windows_NT') {
    throw 'install.ps1 is the Windows installer. On macOS run env/install.sh instead.'
}

$sourceDir = Get-SourceDir
Write-Host ''
Write-Host 'Installing the agentic-101 course environment' -ForegroundColor White
if ($DryRun) { Write-Note 'DRY RUN — nothing will actually change.' }
if ($sourceDir) { Write-Note "using the copy in $sourceDir" } else { Write-Note "downloading from $BaseUrl" }

$pins = Read-VersionPins -SourceDir $sourceDir

# --- 1. applications -------------------------------------------------------

Write-Step 'Step 1 of 3 - installing the applications'

if ($SkipPackages) {
    Write-Note 'skipped (-SkipPackages)'
} else {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw ('winget is not available on this computer. Install "App Installer" from the ' +
               'Microsoft Store, then run this again. If your workplace blocks the Store, ' +
               'tell your facilitator — this is the one step that needs it.')
    }
    Install-WingetPackage -Id 'Git.Git' -Label 'Git for Windows' -Version $pins['GIT_WINDOWS_VERSION']
    Install-WingetPackage -Id 'OpenJS.NodeJS.LTS' -Label 'Node.js' -Version $pins['NODE_WINDOWS_VERSION']

    $wtInstalled = Get-AppxPackage -Name 'Microsoft.WindowsTerminal' -ErrorAction SilentlyContinue
    if ($wtInstalled) {
        Write-Note 'Windows Terminal is already installed'
    } else {
        Install-WingetPackage -Id 'Microsoft.WindowsTerminal' -Label 'Windows Terminal' -Version $pins['WINDOWS_TERMINAL_VERSION']
    }
    Write-Ok 'applications installed'
}

# winget updates this session's PATH only sometimes; find bash by path instead.
$bash = $null
foreach ($root in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:LOCALAPPDATA)) {
    if (-not $root) { continue }
    foreach ($suffix in @('Git\bin\bash.exe', 'Programs\Git\bin\bash.exe')) {
        $candidate = Join-Path $root $suffix
        if (Test-Path -LiteralPath $candidate) { $bash = $candidate; break }
    }
    if ($bash) { break }
}
if (-not $bash -and -not $DryRun) {
    throw ('Git Bash was not found after installing Git for Windows. Close this window, ' +
           'open PowerShell again, and re-run the installer.')
}

# --- 2. Windows Terminal ---------------------------------------------------

Write-Step 'Step 2 of 3 - configuring Windows Terminal for pi'

$patchScript = $null
if ($sourceDir -and (Test-Path -LiteralPath (Join-Path $sourceDir 'windows\Patch-WindowsTerminal.ps1'))) {
    $patchScript = Join-Path $sourceDir 'windows\Patch-WindowsTerminal.ps1'
} else {
    $patchScript = Join-Path $env:TEMP 'agentic-101-Patch-WindowsTerminal.ps1'
    Invoke-WebRequest -UseBasicParsing -Uri "$BaseUrl/windows/Patch-WindowsTerminal.ps1" -OutFile $patchScript
}

if ($DryRun) {
    & $patchScript -DryRun | Out-Null
    Write-Note "would patch Windows Terminal's settings.json"
} else {
    & $patchScript
}

# --- 3. the course commands, via Git Bash ----------------------------------

Write-Step 'Step 3 of 3 - installing the commit and revert commands'

$shArgs = @('--skip-packages')
if ($DryRun) { $shArgs += '--dry-run' }

if ($sourceDir -and (Test-Path -LiteralPath (Join-Path $sourceDir 'install.sh'))) {
    $shPath = ConvertTo-BashPath (Join-Path $sourceDir 'install.sh')
    $command = "bash '$shPath' $($shArgs -join ' ')"
} else {
    $command = "curl -fsSL '$BaseUrl/install.sh' | bash -s -- $($shArgs -join ' ')"
}

if ($DryRun -and -not $bash) {
    Write-Note "would run in Git Bash: $command"
} else {
    & $bash -lc "AGENTIC101_ENV_BASE_URL='$BaseUrl' $command"
    if ($LASTEXITCODE -ne 0) {
        throw "The Git Bash part of the install failed (exit $LASTEXITCODE). Nothing else was changed."
    }
}

# --- done ------------------------------------------------------------------

Write-Host ''
Write-Host "You're set up. One last thing:" -ForegroundColor White
Write-Host '  Close every Windows Terminal window, then open Windows Terminal again' -ForegroundColor Yellow
Write-Host '  (Start menu -> type "Terminal" -> Enter). It will open a Git Bash tab.' -ForegroundColor Yellow
Write-Host '  Everything you do in the course happens in that window.' -ForegroundColor Yellow
Write-Host ''
Write-Host '  Do NOT use the "Git Bash" icon in the Start menu — pi behaves worse there.' -ForegroundColor Yellow
Write-Host ''
