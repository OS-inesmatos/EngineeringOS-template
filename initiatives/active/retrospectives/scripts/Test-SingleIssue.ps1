$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$credPath = Join-Path $scriptDir "..\.credentials"
$emailPath = Join-Path $credPath "jira-email.txt"
$tokenPath = Join-Path $credPath "jira-token.txt"

$email = Get-Content $emailPath
$tokenSecure = Get-Content $tokenPath | ConvertTo-SecureString
$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($tokenSecure)
)

$pair = "${email}:${token}"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$headers = @{
    Authorization = "Basic $encodedCreds"
    "Content-Type" = "application/json"
}

$baseUrl = "https://outsystemsrd.atlassian.net"
$testIssue = "RDINC-72566"

Write-Host "Testing access to $testIssue..." -ForegroundColor Yellow

try {
    $url = "$baseUrl/rest/api/3/issue/$testIssue"
    $issue = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
    Write-Host "SUCCESS: Issue accessible!" -ForegroundColor Green
    Write-Host "  Summary: $($issue.fields.summary)" -ForegroundColor Gray
    Write-Host "  Status: $($issue.fields.status.name)" -ForegroundColor Gray
} catch {
    Write-Host "ERROR: Not accessible: $($_.Exception.Message)" -ForegroundColor Red
}
