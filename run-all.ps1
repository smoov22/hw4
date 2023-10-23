# Script name: run-all.ps1

# Get all .ps1 files in the current directory
$scripts = Get-ChildItem -Path . -Filter *.ps1 

# Loop through the scripts and run them
foreach ($script in $scripts) {
  & $script.FullName
}