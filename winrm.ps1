# Create a scheduler action that stops and disables WinRM
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-Command "& {Stop-Service WinRM; Set-Service WinRM -StartupType Disabled}"' 

# Create a trigger that runs the task every 10 minutes  
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval (New-TimeSpan -Minutes 10) 

# Create the task
$taskName = "Disable WinRM"
$task = New-ScheduledTask -Action $action -Trigger $trigger -Description "Disables and stops the WinRM service every 10 minutes"

# Get credentials to run the task with administrator rights
$username = "administrator"
$password = Read-Host -AsSecureString "Enter password"
$credentials = New-Object System.Management.Automation.PSCredential($username, $password)

# Register the task to run whether the user is logged in or not
Register-ScheduledTask -TaskName $taskName -InputObject $task -User $credentials -RunLevel Highest