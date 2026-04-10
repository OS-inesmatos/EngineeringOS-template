# Test Jira authentication

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$credPath = Join-Path $scriptDir "..\.credentials"
$emailPath = Join-Path $credPath "jira-email.txt"
$tokenPath = Join-Path $credPath "jira-token.txt"

Write-Host "Reading credentials from:" -ForegroundColor Yellow
Write-Host "  $credPath" -ForegroundColor Gray
Write-Host ""

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

Write-Host "Testing authentication..." -ForegroundColor Yellow
$baseUrl = "https://outsystemsrd.atlassian.net"
$url = "$baseUrl/rest/api/3/myself"

try {
    $me = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
    Write-Host "Authentication successful!" -ForegroundColor Green
    Write-Host "  User: $($me.displayName)" -ForegroundColor Cyan
    Write-Host "  Email: $($me.emailAddress)" -ForegroundColor Cyan
    Write-Host ""

    # Now try to search for issues
    Write-Host "Testing issue search..." -ForegroundColor Yellow
    Add-Type -AssemblyName System.Web
    $jql = "project = RDINC ORDER BY created DESC"
    $encodedJql = [System.Web.HttpUtility]::UrlEncode($jql)
    $searchUrl = "$baseUrl/rest/api/3/search?jql=$encodedJql&maxResults=5"

    $results = Invoke-RestMethod -Uri $searchUrl -Method Get -Headers $headers
    Write-Host "Found $($results.total) issues in RDINC project" -ForegroundColor Green

    if ($results.issues -and $results.issues.Count -gt 0) {
        Write-Host ""
        Write-Host "Sample issues:" -ForegroundColor Cyan
        foreach ($issue in $results.issues | Select-Object -First 5) {
            Write-Host "  $($issue.key) - $($issue.fields.summary)" -ForegroundColor Gray
        }
    }

} catch {
    Write-Host "Error!" -ForegroundColor Red
    Write-Host "  $($_.Exception.Message)" -ForegroundColor Red
}
