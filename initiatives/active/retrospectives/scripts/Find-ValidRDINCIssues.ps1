# Find valid RDINC issues with System-wide impact = Yes

# Use credentials relative to script location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$credPath = Join-Path $scriptDir "..\.credentials"
$emailPath = Join-Path $credPath "jira-email.txt"
$tokenPath = Join-Path $credPath "jira-token.txt"

if (-not (Test-Path $emailPath) -or -not (Test-Path $tokenPath)) {
    Write-Host "ERROR: Credentials not found. Run Setup-JiraCredentials.ps1 first." -ForegroundColor Red
    exit 1
}

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

Write-Host ""
Write-Host "=== Searching for RDINC Issues with System-wide Impact ===" -ForegroundColor Cyan
Write-Host ""

# Search for RDINC issues in the last 12 months
Add-Type -AssemblyName System.Web
$jql = 'project = RDINC AND created >= -365d ORDER BY created DESC'
$encodedJql = [System.Web.HttpUtility]::UrlEncode($jql)
$url = "$baseUrl/rest/api/3/search/jql?jql=$encodedJql&maxResults=50&fields=key,summary,created,status"

Write-Host "Searching with JQL: $jql" -ForegroundColor Gray
Write-Host ""

try {
    $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

    Write-Host "DEBUG: Response type: $($response.GetType().Name)" -ForegroundColor Magenta
    Write-Host "DEBUG: Response properties: $($response | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name)" -ForegroundColor Magenta
    Write-Host "DEBUG: Total: $($response.total)" -ForegroundColor Magenta
    Write-Host "DEBUG: Issues count: $($response.issues.Count)" -ForegroundColor Magenta
    Write-Host ""

    Write-Host "Found $($response.total) issues" -ForegroundColor Green
    Write-Host ""

    if ($response.issues -and $response.issues.Count -gt 0) {
        Write-Host "=== Recent Issues ===" -ForegroundColor Cyan
        foreach ($issue in $response.issues) {
            $key = $issue.key
            $summary = $issue.fields.summary
            $created = $issue.fields.created
            $status = $issue.fields.status.name

            Write-Host "$key - $status - $summary" -ForegroundColor Yellow
            Write-Host "  Created: $created" -ForegroundColor Gray
        }

        Write-Host ""
        Write-Host "=== Saving to File ===" -ForegroundColor Cyan
        $issueKeys = $response.issues | ForEach-Object { $_.key }
        $issueKeys | Out-File "issues-system-wide-recent.txt" -Encoding utf8
        Write-Host "Saved $($issueKeys.Count) issue keys to: issues-system-wide-recent.txt" -ForegroundColor Green
    } else {
        Write-Host "No issues found matching criteria" -ForegroundColor Yellow
    }

} catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $reader.BaseStream.Position = 0
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody" -ForegroundColor Gray
    }
}
