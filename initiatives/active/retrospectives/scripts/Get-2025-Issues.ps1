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

Write-Host ""
Write-Host "=== Fetching 2025 Retrospective Issues ===" -ForegroundColor Cyan
Write-Host ""

# JQL from summary document
$jql = "project = RDINC AND (status = 'Retrospective Completed' OR status = Closed) AND 'Retrospective Needed' = Yes AND resolved >= '2025-01-01' AND resolved <= '2025-12-31'"

Write-Host "JQL Query:" -ForegroundColor Yellow
Write-Host $jql -ForegroundColor Gray
Write-Host ""

try {
    Add-Type -AssemblyName System.Web
    $encodedJql = [System.Web.HttpUtility]::UrlEncode($jql)

    $allIssues = @()
    $startAt = 0
    $maxResults = 100
    $total = 0

    do {
        # Use API v2 which still works
        $url = "$baseUrl/rest/api/2/search"
        Write-Host "Fetching issues $startAt to $($startAt + $maxResults)..." -ForegroundColor Gray

        $body = @{
            jql = $jql
            startAt = $startAt
            maxResults = $maxResults
            fields = @("key", "summary")
        } | ConvertTo-Json

        $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body

        if ($startAt -eq 0) {
            $total = $response.total
            Write-Host "Found $total issues total" -ForegroundColor Green
        }

        $allIssues += $response.issues
        $startAt += $maxResults

        Start-Sleep -Milliseconds 500

    } while ($allIssues.Count -lt $total)

    Write-Host ""
    Write-Host "=== Summary ===" -ForegroundColor Cyan
    Write-Host "Total issues fetched: $($allIssues.Count)" -ForegroundColor Green
    Write-Host ""

    # Save issue keys to file
    $issueKeys = $allIssues | ForEach-Object { $_.key }
    $outputFile = "issues-2025-retrospectives.txt"
    $issueKeys | Out-File $outputFile -Encoding utf8

    Write-Host "Saved issue keys to: $outputFile" -ForegroundColor Green
    Write-Host ""

    # Show first 10 as sample
    Write-Host "Sample (first 10):" -ForegroundColor Yellow
    $allIssues | Select-Object -First 10 | ForEach-Object {
        Write-Host "  $($_.key) - $($_.fields.summary)" -ForegroundColor Gray
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
