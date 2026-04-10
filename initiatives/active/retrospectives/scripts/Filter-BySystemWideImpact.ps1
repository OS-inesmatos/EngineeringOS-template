# Filter issues by System-wide impact? = Yes

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

# Read issue keys
$issues = Get-Content "issues-list.txt"

Write-Host ""
Write-Host "=== Filtering by System-wide impact? = Yes ===" -ForegroundColor Cyan
Write-Host "Checking $($issues.Count) issues..." -ForegroundColor Gray
Write-Host ""

$systemWideIssues = @()

foreach ($issueKey in $issues) {
    Write-Host "Checking $issueKey..." -NoNewline

    try {
        $url = "$baseUrl/rest/api/3/issue/$issueKey"
        $issue = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

        # Check customfield_16516 (System-wide impact?)
        $systemWideImpact = $issue.fields.customfield_16516

        # The field is an object with .value property
        $isSystemWide = $false
        if ($systemWideImpact -and $systemWideImpact.value -eq "Yes") {
            $isSystemWide = $true
        }

        if ($isSystemWide) {
            Write-Host " YES" -ForegroundColor Green
            $systemWideIssues += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                Status = $issue.fields.status.name
                SystemWideImpact = "Yes"
            }
        } else {
            Write-Host " No ($systemWideImpact)" -ForegroundColor Gray
        }

    } catch {
        Write-Host " Error: $($_.Exception.Message)" -ForegroundColor Red
    }

    Start-Sleep -Milliseconds 300
}

Write-Host ""
Write-Host "=== Results ===" -ForegroundColor Cyan
Write-Host "Total issues checked: $($issues.Count)"
Write-Host "Issues with System-wide impact = Yes: $($systemWideIssues.Count)" -ForegroundColor Green
Write-Host ""

if ($systemWideIssues.Count -gt 0) {
    # Display results
    Write-Host "System-wide Impact Issues:" -ForegroundColor Yellow
    $systemWideIssues | Format-Table Issue, Status, Summary -AutoSize

    # Save to file
    $issueKeys = $systemWideIssues | Select-Object -ExpandProperty Issue
    $issueKeys | Out-File "issues-system-wide.txt" -Force

    Write-Host ""
    Write-Host "Issue keys saved to: issues-system-wide.txt" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next: Filter the CSV to show only these issues" -ForegroundColor Cyan
} else {
    Write-Host "No issues found with System-wide impact = Yes" -ForegroundColor Yellow
}
