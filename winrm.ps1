# Create scheduled task action
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '& {Stop-Service WinRM; Set-Service WinRM -StartupType Disabled}'

# Create trigger 
$triggerDate = Get-Date
$trigger = New-ScheduledTaskTrigger -Once -At $triggerDate -RepetitionInterval (New-TimeSpan -Minutes 10)

# Create task
$taskName = "Disable WinRM" 
$task = New-ScheduledTask -Action $action -Trigger $trigger -Description "Disables and stops the WinRM service every 10 minutes"

# Get credentials
$username = "administrator"
$password = Read-Host -Prompt "Enter password" -AsSecureString
$credentials = New-Object System.Management.Automation.PSCredential($username, $password)

# Register task
Register-ScheduledTask -ParameterSetName RegisterTaskUser -TaskName $taskName -InputObject $task -UserName $credentials.UserName -Password $credentials.Password -RunLevel Highest