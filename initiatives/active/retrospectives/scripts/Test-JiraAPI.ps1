# Test different Jira API endpoints

# Load credentials
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

$baseUrl = "https://outsystemsrd.atlassian.net"

Write-Host "Testing Jira API access..." -ForegroundColor Cyan
Write-Host "Email: $email"
Write-Host ""

# Test 1: Get current user
Write-Host "Test 1: Get current user..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/rest/api/3/myself" -Method Get -Headers $headers
    Write-Host "  Success! User: $($response.displayName)" -ForegroundColor Green
} catch {
    Write-Host "  Failed: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# Test 2: Search for issue
Write-Host "Test 2: Search for RDINC-67391..." -ForegroundColor Yellow
try {
    $jql = "key=RDINC-67391"
    $searchUrl = "$baseUrl/rest/api/3/search?jql=$jql"
    $response = Invoke-RestMethod -Uri $searchUrl -Method Get -Headers $headers
    Write-Host "  Success! Found $($response.total) issue(s)" -ForegroundColor Green
    if ($response.total -gt 0) {
        Write-Host "  Issue: $($response.issues[0].key) - $($response.issues[0].fields.status.name)" -ForegroundColor Green
    }
} catch {
    Write-Host "  Failed: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# Test 3: Get issue directly
Write-Host "Test 3: Get issue RDINC-67391 directly..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/rest/api/3/issue/RDINC-67391" -Method Get -Headers $headers
    Write-Host "  Success! Issue: $($response.key)" -ForegroundColor Green
} catch {
    Write-Host "  Failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "  Status Code: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Red
}
Write-Host ""

# Test 4: Get issue with changelog
Write-Host "Test 4: Get issue with changelog..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/rest/api/3/issue/RDINC-67391?expand=changelog" -Method Get -Headers $headers
    Write-Host "  Success! Changelog entries: $($response.changelog.histories.Count)" -ForegroundColor Green
} catch {
    Write-Host "  Failed: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""
