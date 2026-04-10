<#
.SYNOPSIS
    Get retrospective metrics using acli

.PARAMETER IssueKeys
    Array of issue keys to process

.EXAMPLE
    .\Get-StatusMetrics-ACLI.ps1 -IssueKeys @("RDINC-67391")
#>

param(
    [Parameter(Mandatory=$true)]
    [string[]]$IssueKeys
)

Write-Host ""
Write-Host "=== Jira Retrospective Metrics (using ACLI) ===" -ForegroundColor Cyan
Write-Host ""

$allResults = @()

foreach ($issueKey in $IssueKeys) {
    Write-Host "Processing $issueKey..." -ForegroundColor Gray

    # Get issue data with acli
    $jsonOutput = acli jira workitem view $issueKey --json 2>&1 | Out-String

    if ($LASTEXITCODE -ne 0) {
        Write-Host "  Error getting issue $issueKey" -ForegroundColor Red
        continue
    }

    try {
        $issue = $jsonOutput | ConvertFrom-Json

        Write-Host "  Issue: $($issue.key)" -ForegroundColor Green
        Write-Host "  Status: $($issue.fields.status.name)" -ForegroundColor Green
        Write-Host "  Summary: $($issue.fields.summary.Substring(0, [Math]::Min(60, $issue.fields.summary.Length)))..."

        # For now, let's see what we get
        Write-Host "  Note: Changelog not available via standard acli view" -ForegroundColor Yellow
        Write-Host ""

    } catch {
        Write-Host "  Error parsing JSON: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Note: The acli tool doesn't provide changelog data through the view command." -ForegroundColor Yellow
Write-Host "We need to use the Jira REST API for status history." -ForegroundColor Yellow
Write-Host ""
Write-Host "Checking API access..." -ForegroundColor Cyan
