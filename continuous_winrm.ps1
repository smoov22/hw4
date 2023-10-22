while ($true) {
    Stop-Service WinRM 
    Set-Service WinRM -StartupType Disabled
    Start-Sleep -Seconds 600
  }