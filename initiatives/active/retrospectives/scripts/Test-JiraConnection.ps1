# Test Jira connection and get single issue

param(
    [Parameter(Mandatory=$true)]
    [string]$IssueKey
)

# Load credentials
$credPath = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\.credentials"
$emailPath = Join-Path $credPath "jira-email.txt"
$tokenPath = Join-Path $credPath "jira-token.txt"

if (-not (Test-Path $emailPath) -or -not (Test-Path $tokenPath)) {
    Write-Host "Error: Credentials not found!" -ForegroundColor Red
    Write-Host "Run Setup-JiraCredentials.ps1 first." -ForegroundColor Yellow
    exit 1
}

$email = Get-Content $emailPath
$tokenSecure = Get-Content $tokenPath | ConvertTo-SecureString
$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($tokenSecure)
)

Write-Host "Connecting to Jira..." -ForegroundColor Cyan
Write-Host "Email: $email"
Write-Host ""

# Call Jira API
$JiraBaseUrl = "https://outsystemsrd.atlassian.net"
$ApiUrl = "$JiraBaseUrl/rest/api/3/issue/$IssueKey?expand=changelog"

$pair = "$($email):$($token)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$headers = @{
    Authorization = "Basic $encodedCreds"
    "Content-Type" = "application/json"
}

try {
    $response = Invoke-RestMethod -Uri $ApiUrl -Method Get -Headers $headers

    Write-Host "Success!" -ForegroundColor Green
    Write-Host "Issue: $($response.key)"
    Write-Host "Summary: $($response.fields.summary)"
    Write-Host "Status: $($response.fields.status.name)"
    Write-Host ""
    Write-Host "Changelog entries: $($response.changelog.histories.Count)"

} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
