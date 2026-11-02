# Set-ChromeDarkMode

A lightweight PowerShell script to switch Google Chrome's automatic darkening of **web content** on or off using the `WebContentsForceDark` feature flag.

## Requirements

- Windows 10 or Windows 11
- Windows PowerShell 5.1 or PowerShell 7+
- Google Chrome installed

## Installation

Install from PowerShell Gallery:

```powershell
Install-Script -Name Set-ChromeDarkMode -Scope CurrentUser
```

If the command is not recognized after installation, restart PowerShell and verify the installed scripts directory is in `PATH`.

## Usage

Enable automatic darkening of web content:

```powershell
Set-ChromeDarkMode.ps1 -Mode dark
```

Disable automatic darkening of web content:

```powershell
Set-ChromeDarkMode.ps1 -Mode light
```

To run a downloaded copy from the current directory, use `./Set-ChromeDarkMode.ps1` (or `.\Set-ChromeDarkMode.ps1` in PowerShell).

## Parameters

| Parameter | Required | Values | Description |
| --- | --- | --- | --- |
| `Mode` | Yes | `dark`, `light` | Enables or disables Chrome's automatic darkening of web content. |

## How it works

If Chrome is running, the script closes Chrome and restarts it with one of these flags:

- `dark`: `--enable-features=WebContentsForceDark`
- `light`: `--disable-features=WebContentsForceDark`

It also requests session restoration using `--restore-last-session`.

## Important notes

- **Save your work before running.** The script force-closes Chrome, which can cause loss of unsaved form data or other browser state.
- In the original implementation, the script does nothing if Chrome is not running.
- The original implementation expects Chrome at `C:\Program Files (x86)\Google\Chrome\Application\chrome.exe`.
- This changes the behavior of web pages, **not** the Windows theme or all of Chrome's interface.
- Chrome's support for this feature can vary by version; reopening the previous session is not guaranteed.

## Troubleshooting

**Chrome does not restart:** Check that Chrome is installed at the path used by the script.

**Web pages do not change appearance:** Confirm Chrome restarted with the requested flag. Some sites or Chrome versions may not respond to it.

**Command not found:** Restart PowerShell, or run the `.ps1` file using its full path.

## License

Licensed under the MIT License. See [LICENSE](LICENSE) for details.
