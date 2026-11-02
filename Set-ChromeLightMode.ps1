<#PSScriptInfo

.VERSION 1.0.0

.GUID 3c3fed78-54c5-4c2c-bff7-989ecfd449ed

.AUTHOR Sha256Encrypted

.TAGS Chrome DarkMode LightMode Browser Theme Windows

#>

<#
.SYNOPSIS
Switches Google Chrome between dark and light web content modes.

.DESCRIPTION
Changes Google Chrome's automatic darkening behavior using
the WebContentsForceDark feature flag.

Supports dark and light modes through the Mode parameter.

If Chrome is currently running, the script closes Chrome
and restarts it with the selected mode while attempting
to restore the previous browsing session.

.PARAMETER Mode
Specifies the desired Chrome web content mode.

Accepted values:
- dark  : Enables automatic darkening of web content.
- light : Disables automatic darkening of web content.

.EXAMPLE
.\Set-ChromeDarkMode.ps1 -Mode dark

Enables automatic darkening of web content in Chrome.

.EXAMPLE
.\Set-ChromeDarkMode.ps1 -Mode light

Disables automatic darkening of web content in Chrome.
#>

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('light', 'dark')]
    [string]$Mode
)

$chromeWasRunning = $null -ne (Get-Process -Name chrome -ErrorAction SilentlyContinue)

if ($Mode -eq 'dark') {
    $chromeThemeArgument = '--enable-features=WebContentsForceDark'
}
else {
    $chromeThemeArgument = '--disable-features=WebContentsForceDark'
}

if ($chromeWasRunning) {
    $chromePath = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'

    Stop-Process -Name chrome -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Start-Process $chromePath -ArgumentList "$chromeThemeArgument --restore-last-session --hide-crash-restore-bubble"
}