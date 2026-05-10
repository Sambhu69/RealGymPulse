$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
Invoke-WebRequest -Uri 'http://localhost:8081/GymPulse/login' -WebSession $session -Method Post -Body @{userEmail='milanPstar@gmail.com'; userPassword='Password123!'} | Out-Null
$cancelReq = Invoke-WebRequest -Uri 'http://localhost:8081/GymPulse/member/book?action=cancel&bookingId=1&classId=1' -WebSession $session -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "Status: $($cancelReq.StatusCode)"
Write-Host "Location: $($cancelReq.Headers.Location)"
