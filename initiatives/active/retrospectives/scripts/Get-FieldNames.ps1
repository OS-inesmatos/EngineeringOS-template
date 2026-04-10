# Get field names mapping from Jira

$credPath = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\.credentials"
$emailPath = Join-Path $credPath "jira-email.txt"
$tokenPath = Join-Path $credPath "jira-token.txt"

$email = Get-Content $emailPath
$tokenSecure = Get-Content $tokenPath | ConvertTo-SecureString
$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($tokenSecure)
)

$pair = "$($email):$($token)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$headers = @{
    Authorization = "Basic $encodedCreds"
    "Content-Type" = "application/json"
}

Write-Host "Fetching all Jira fields..." -ForegroundColor Cyan

try {
    $fields = Invoke-RestMethod -Uri "https://outsystemsrd.atlassian.net/rest/api/3/field" -Method Get -Headers $headers

    Write-Host "Total fields: $($fields.Count)" -ForegroundColor Green
    Write-Host ""
    Write-Host "Searching for 'system-wide' or 'impact' fields..." -ForegroundColor Yellow
    Write-Host ""

    foreach ($field in $fields) {
        if ($field.name -match "system|wide|impact" -or $field.id -match "16013|17293|15462|17854|17853|16516") {
            Write-Host "$($field.id) - $($field.name)" -ForegroundColor Green
        }
    }

    # Save to file
    $fields | ConvertTo-Json -Depth 5 | Out-File "jira-fields.json"
    Write-Host ""
    Write-Host "All fields saved to: jira-fields.json" -ForegroundColor Gray

} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
