<#
.SYNOPSIS
    Filter RDINC issues by System-wide impact field

.PARAMETER InputFile
    CSV file with issue keys

.EXAMPLE
    .\Filter-SystemWideImpact.ps1 -InputFile "issues-last-6months.csv"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile
)

# Load credentials
$credPath = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\.credentials"
$emailPath = Join-Path $credPath "jira-email.txt"
$tokenPath = Join-Path $credPath "jira-token.txt"

if (-not (Test-Path $emailPath) -or -not (Test-Path $tokenPath)) {
    Write-Host "Error: Credentials not found!" -ForegroundColor Red
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

# Read issue keys
$issues = Import-Csv -Path $InputFile | Select-Object -ExpandProperty Key

Write-Host ""
Write-Host "=== Filtering issues by System-wide impact ===" -ForegroundColor Cyan
Write-Host "Total issues to check: $($issues.Count)"
Write-Host ""

$filteredIssues = @()

foreach ($issueKey in $issues) {
    Write-Host "Checking $issueKey..." -NoNewline

    try {
        $url = "$baseUrl/rest/api/3/issue/$issueKey"
        $issue = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

        # Look for System-wide impact field
        # The field might be named differently, so we'll search through all fields
        $systemWideImpact = $null

        # Check common field names
        $fields = $issue.fields.PSObject.Properties | Where-Object {
            $_.Name -match "system.*wide|impact" -or
            $_.Value.ToString() -match "System-wide"
        }

        # Try to find the field value
        foreach ($field in $issue.fields.PSObject.Properties) {
            $value = $field.Value
            if ($value -is [PSCustomObject]) {
                if ($value.PSObject.Properties.Name -contains "value" -and
                    $value.value -eq "Yes") {
                    $systemWideImpact = "Yes"
                    break
                }
            } elseif ($value -eq "Yes") {
                $systemWideImpact = "Yes"
                break
            }
        }

        if ($systemWideImpact -eq "Yes") {
            Write-Host " YES" -ForegroundColor Green
            $filteredIssues += $issueKey
        } else {
            Write-Host " No" -ForegroundColor Gray
        }

    } catch {
        Write-Host " Error: $($_.Exception.Message)" -ForegroundColor Red
    }

    Start-Sleep -Milliseconds 300
}

Write-Host ""
Write-Host "=== Results ===" -ForegroundColor Cyan
Write-Host "Total issues checked: $($issues.Count)"
Write-Host "Issues with System-wide impact = Yes: $($filteredIssues.Count)" -ForegroundColor Green
Write-Host ""

if ($filteredIssues.Count -gt 0) {
    # Save filtered list
    $outputFile = "issues-system-wide-impact.txt"
    $filteredIssues | Out-File -FilePath $outputFile -Force

    Write-Host "Filtered issues saved to: $outputFile" -ForegroundColor Green
    Write-Host ""
    Write-Host "Issues:" -ForegroundColor Yellow
    $filteredIssues | ForEach-Object { Write-Host "  $_" }
    Write-Host ""
    Write-Host "Next step: Run retrospective metrics analysis" -ForegroundColor Cyan
    Write-Host "  `$issues = Get-Content $outputFile"
    Write-Host "  .\Get-RetroMetrics.ps1 -IssueKeys `$issues"
} else {
    Write-Host "No issues found with System-wide impact = Yes" -ForegroundColor Yellow
}
