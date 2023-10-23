# Create a log file
$logFile = "C:\tmp\homebase.txt"

# Add a key down event handler
$script:keydown = {
  $key = $args[1]
  $date = Get-Date -Format "hh:mm:ss tt"
  Add-Content -Path $logFile -Value "$date - Key down: $key"
}

# Register the event handler
Register-EngineEvent -SourceIdentifier KeyDown -Action $keydown

