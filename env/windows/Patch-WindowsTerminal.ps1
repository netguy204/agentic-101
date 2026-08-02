<#
.SYNOPSIS
    Configure Windows Terminal for the agentic-101 course environment.

.DESCRIPTION
    Chunk: docs/chunks/onboarding_terminal_env - Windows Terminal configuration

    Two changes, both required by DEC-007:

    1. pi's documented sendInput bindings for Shift+Enter and Alt+Enter
       (pi docs/terminal-setup.md). Stable Windows Terminal 1.24 has no native
       Kitty keyboard protocol, so without these pi cannot tell Shift+Enter
       from Enter; and Windows Terminal binds Alt+Enter to fullscreen, which
       shadows pi's follow-up queueing even once native support arrives. The
       bindings stay harmless after 1.25 reaches stable.

    2. A Git Bash profile, set as the default. Git Bash is pi's own documented
       Windows shell (pi docs/windows.md), and making it the default profile is
       what keeps participants out of the Start-menu "Git Bash" (mintty) icon,
       where pi's keys and Node both behave worse.

    The existing settings.json is backed up before any change, and every object
    this script adds is tagged so that re-running replaces rather than
    duplicates it.

    AUTHORED BUT NOT EXECUTED ON WINDOWS — see env/README.md. The JSON
    transformation has been verified against fixtures; the Windows-specific
    paths and Windows Terminal's live reload have not.

.PARAMETER SettingsPath
    Path to settings.json. Defaults to the Store install, then the unpackaged
    install.

.PARAMETER DryRun
    Print what would change and write nothing.
#>
[CmdletBinding()]
param(
    [string]$SettingsPath,
    [switch]$DryRun
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$ProfileGuid = '{5f1b98b3-9d4c-4b0f-9a1e-6d2c7a8e4f11}'
$ActionTagPrefix = 'agentic-101:'

function Write-Step { param([string]$Text) Write-Host $Text -ForegroundColor Cyan }
function Write-Ok   { param([string]$Text) Write-Host "  $Text" -ForegroundColor Green }
function Write-Note { param([string]$Text) Write-Host "  $Text" -ForegroundColor DarkGray }

function Remove-JsonNoise {
    <#
      Windows Terminal writes JSONC: // comments, /* */ comments, and trailing
      commas, none of which ConvertFrom-Json accepts on Windows PowerShell 5.1.
      This strips them with a character scanner rather than a regex, so a "//"
      inside a string value (a path, a URL) is left alone.
    #>
    param([Parameter(Mandatory = $true)][string]$Text)

    $sb = New-Object System.Text.StringBuilder
    $inString = $false
    $escaped = $false
    $i = 0
    while ($i -lt $Text.Length) {
        $c = $Text[$i]
        if ($inString) {
            [void]$sb.Append($c)
            if ($escaped) { $escaped = $false }
            elseif ($c -eq '\') { $escaped = $true }
            elseif ($c -eq '"') { $inString = $false }
            $i++
            continue
        }
        if ($c -eq '"') { $inString = $true; [void]$sb.Append($c); $i++; continue }
        if ($c -eq '/' -and ($i + 1) -lt $Text.Length) {
            $next = $Text[$i + 1]
            if ($next -eq '/') {
                while ($i -lt $Text.Length -and $Text[$i] -ne "`n") { $i++ }
                continue
            }
            if ($next -eq '*') {
                $i += 2
                while (($i + 1) -lt $Text.Length -and -not ($Text[$i] -eq '*' -and $Text[$i + 1] -eq '/')) { $i++ }
                $i += 2
                continue
            }
        }
        [void]$sb.Append($c)
        $i++
    }

    # Trailing commas: a comma whose next non-whitespace character closes a
    # container. Same string-awareness applies, so scan the stripped text.
    $text2 = $sb.ToString()
    $out = New-Object System.Text.StringBuilder
    $inString = $false
    $escaped = $false
    for ($i = 0; $i -lt $text2.Length; $i++) {
        $c = $text2[$i]
        if ($inString) {
            [void]$out.Append($c)
            if ($escaped) { $escaped = $false }
            elseif ($c -eq '\') { $escaped = $true }
            elseif ($c -eq '"') { $inString = $false }
            continue
        }
        if ($c -eq '"') { $inString = $true; [void]$out.Append($c); continue }
        if ($c -eq ',') {
            $j = $i + 1
            while ($j -lt $text2.Length -and [char]::IsWhiteSpace($text2[$j])) { $j++ }
            if ($j -lt $text2.Length -and ($text2[$j] -eq '}' -or $text2[$j] -eq ']')) { continue }
        }
        [void]$out.Append($c)
    }
    return $out.ToString()
}

function Test-BoundToChord {
    # True when an actions/keybindings entry claims one of pi's two chords.
    param($Entry, [string[]]$Chords)
    if ($null -eq $Entry) { return $false }
    if (-not ($Entry.PSObject.Properties.Name -contains 'keys')) { return $false }
    $keys = $Entry.keys
    if ($null -eq $keys) { return $false }
    foreach ($k in @($keys)) {
        $norm = ($k -replace '\s', '').ToLowerInvariant()
        if ($Chords -contains $norm) { return $true }
    }
    return $false
}

function Get-GitBashPath {
    # Program Files (x86) is absent on some installs, so build the list from
    # whichever roots actually exist rather than assuming all three.
    $roots = @()
    foreach ($r in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:LOCALAPPDATA)) {
        if ($r) { $roots += $r }
    }
    foreach ($root in $roots) {
        foreach ($suffix in @('Git\bin\bash.exe', 'Programs\Git\bin\bash.exe')) {
            $candidate = Join-Path $root $suffix
            if (Test-Path -LiteralPath $candidate) { return $candidate }
        }
    }
    # Fall back to whatever git is on PATH: <root>\cmd\git.exe -> <root>\bin\bash.exe
    $git = Get-Command git.exe -ErrorAction SilentlyContinue
    if ($git) {
        $guess = Join-Path (Split-Path -Parent (Split-Path -Parent $git.Source)) 'bin\bash.exe'
        if (Test-Path -LiteralPath $guess) { return $guess }
    }
    return $null
}

function Resolve-SettingsPath {
    param([string]$Explicit)
    if ($Explicit) { return $Explicit }
    $store = Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
    $plain = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows Terminal\settings.json'
    if (Test-Path -LiteralPath $store) { return $store }
    if (Test-Path -LiteralPath $plain) { return $plain }
    # Neither exists: Windows Terminal has never been opened. Write the
    # unpackaged path only if its directory exists, otherwise the Store one,
    # creating the directory.
    if (Test-Path -LiteralPath (Split-Path -Parent $plain)) { return $plain }
    return $store
}

# --- locate settings.json --------------------------------------------------

Write-Step 'Configuring Windows Terminal for pi'

$settings = Resolve-SettingsPath -Explicit $SettingsPath
Write-Note "settings file: $settings"

$json = $null
if (Test-Path -LiteralPath $settings) {
    $raw = Get-Content -LiteralPath $settings -Raw -Encoding UTF8
    if ($raw.Trim().Length -gt 0) {
        try {
            $json = (Remove-JsonNoise -Text $raw) | ConvertFrom-Json
        } catch {
            throw ("Could not read $settings as JSON ($($_.Exception.Message)). " +
                   'Nothing was changed. Fix or delete that file and run this again.')
        }
    }
}
if ($null -eq $json) {
    $json = New-Object PSObject
    Add-Member -InputObject $json -MemberType NoteProperty -Name '$schema' `
               -Value 'https://aka.ms/terminal-profiles-schema'
}

function Add-MissingProperty {
    param($Object, [string]$Name, $Value)
    if (-not ($Object.PSObject.Properties.Name -contains $Name)) {
        Add-Member -InputObject $Object -MemberType NoteProperty -Name $Name -Value $Value
    }
}

# --- 1. pi's key bindings --------------------------------------------------

$esc = [string][char]27
$piChords = @('shift+enter', 'alt+enter')

Add-MissingProperty -Object $json -Name 'actions' -Value @()

$keptActions = @()
foreach ($a in @($json.actions)) {
    if (Test-BoundToChord -Entry $a -Chords $piChords) { continue }
    $keptActions += $a
}

$shiftEnter = New-Object PSObject
Add-Member -InputObject $shiftEnter -MemberType NoteProperty -Name 'name' -Value "$ActionTagPrefix pi newline (Shift+Enter)"
Add-Member -InputObject $shiftEnter -MemberType NoteProperty -Name 'keys' -Value 'shift+enter'
$shiftCmd = New-Object PSObject
Add-Member -InputObject $shiftCmd -MemberType NoteProperty -Name 'action' -Value 'sendInput'
Add-Member -InputObject $shiftCmd -MemberType NoteProperty -Name 'input' -Value "$esc[13;2u"
Add-Member -InputObject $shiftEnter -MemberType NoteProperty -Name 'command' -Value $shiftCmd

$altEnter = New-Object PSObject
Add-Member -InputObject $altEnter -MemberType NoteProperty -Name 'name' -Value "$ActionTagPrefix pi follow-up (Alt+Enter)"
Add-Member -InputObject $altEnter -MemberType NoteProperty -Name 'keys' -Value 'alt+enter'
$altCmd = New-Object PSObject
Add-Member -InputObject $altCmd -MemberType NoteProperty -Name 'action' -Value 'sendInput'
Add-Member -InputObject $altCmd -MemberType NoteProperty -Name 'input' -Value "$esc[13;3u"
Add-Member -InputObject $altEnter -MemberType NoteProperty -Name 'command' -Value $altCmd

$json.actions = @($keptActions) + @($shiftEnter, $altEnter)

# The legacy "keybindings" array wins over "actions" where both bind a chord,
# so strip our two chords out of it as well.
if ($json.PSObject.Properties.Name -contains 'keybindings') {
    $json.keybindings = @(@($json.keybindings) | Where-Object { -not (Test-BoundToChord -Entry $_ -Chords $piChords) })
}

Write-Ok 'Shift+Enter and Alt+Enter will be forwarded to pi'

# --- 2. Git Bash as the default profile ------------------------------------

$gitBash = Get-GitBashPath
if (-not $gitBash) {
    throw ('Git Bash was not found (looked for Git\bin\bash.exe under Program Files). ' +
           'Install Git for Windows first — install.ps1 does this for you. Nothing was changed.')
}

Add-MissingProperty -Object $json -Name 'profiles' -Value (New-Object PSObject)
if ($json.profiles -is [System.Array]) {
    # Very old schema: profiles was a bare array. Wrap it in the modern shape.
    $wrapped = New-Object PSObject
    Add-Member -InputObject $wrapped -MemberType NoteProperty -Name 'list' -Value @($json.profiles)
    $json.profiles = $wrapped
}
Add-MissingProperty -Object $json.profiles -Name 'list' -Value @()

$gitBashProfile = New-Object PSObject
Add-Member -InputObject $gitBashProfile -MemberType NoteProperty -Name 'guid' -Value $ProfileGuid
Add-Member -InputObject $gitBashProfile -MemberType NoteProperty -Name 'name' -Value 'Git Bash'
Add-Member -InputObject $gitBashProfile -MemberType NoteProperty -Name 'commandline' -Value ('"{0}" -i -l' -f $gitBash)
Add-Member -InputObject $gitBashProfile -MemberType NoteProperty -Name 'startingDirectory' -Value '%USERPROFILE%'
Add-Member -InputObject $gitBashProfile -MemberType NoteProperty -Name 'hidden' -Value $false

$icon = Join-Path (Split-Path -Parent (Split-Path -Parent $gitBash)) 'mingw64\share\git\git-for-windows.ico'
if (Test-Path -LiteralPath $icon) {
    Add-Member -InputObject $gitBashProfile -MemberType NoteProperty -Name 'icon' -Value $icon
}

$keptProfiles = @(@($json.profiles.list) | Where-Object {
    $null -ne $_ -and -not (($_.PSObject.Properties.Name -contains 'guid') -and $_.guid -eq $ProfileGuid)
})
$json.profiles.list = @($keptProfiles) + @($gitBashProfile)

Add-MissingProperty -Object $json -Name 'defaultProfile' -Value $ProfileGuid
$json.defaultProfile = $ProfileGuid

Write-Ok 'Git Bash is the profile Windows Terminal opens by default'

# --- write it back ---------------------------------------------------------

$output = $json | ConvertTo-Json -Depth 32

if ($DryRun) {
    Write-Note 'DRY RUN — settings.json was not written. Result would be:'
    Write-Output $output
    return
}

$dir = Split-Path -Parent $settings
if ($dir -and -not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

if (Test-Path -LiteralPath $settings) {
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backup = "$settings.agentic-101-backup-$stamp"
    Copy-Item -LiteralPath $settings -Destination $backup -Force
    Write-Note "backed up to $(Split-Path -Leaf $backup)"
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($settings, $output, $utf8NoBom)

Write-Ok 'Windows Terminal configured'
Write-Host ''
Write-Host '  Close every Windows Terminal window and open it again for this to take effect.' -ForegroundColor Yellow
