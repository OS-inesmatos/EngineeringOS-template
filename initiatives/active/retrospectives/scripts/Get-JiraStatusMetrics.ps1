<#
.SYNOPSIS
    Get time spent in each status for Jira incidents

.DESCRIPTION
    This script retrieves the changelog for a Jira issue and calculates
    the time spent in Solved, Retrospective In Progress, and Retrospective Completed statuses.

.PARAMETER IssueKey
    The Jira issue key (e.g., RDINC-67391)

.PARAMETER Email
    Your Jira email address

.PARAMETER ApiToken
    Your Jira API token (create one at: https://id.atlassian.com/manage-profile/security/api-tokens)

.EXAMPLE
    .\Get-JiraStatusMetrics.ps1 -IssueKey "RDINC-67391" -Email "your.email@outsystems.com" -ApiToken "your_api_token"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$IssueKey,

    [Parameter(Mandatory=$true)]
    [string]$Email,

    [Parameter(Mandatory=$true)]
    [string]$ApiToken
)

$JiraBaseUrl = "https://outsystemsrd.atlassian.net"
$ApiUrl = "$JiraBaseUrl/rest/api/3/issue/$IssueKey?expand=changelog"

# Create authentication header
$pair = "$($Email):$($ApiToken)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$headers = @{
    Authorization = "Basic $encodedCreds"
    "Content-Type" = "application/json"
}

Write-Host "Fetching issue $IssueKey..." -ForegroundColor Cyan

try {
    $response = Invoke-RestMethod -Uri $ApiUrl -Method Get -Headers $headers

    Write-Host "`nIssue: $($response.key) - $($response.fields.summary)" -ForegroundColor Green
    Write-Host "Current Status: $($response.fields.status.name)" -ForegroundColor Yellow

    # Extract status changes from changelog
    $statusChanges = @()

    foreach ($history in $response.changelog.histories) {
        foreach ($item in $history.items) {
            if ($item.field -eq "status") {
                $statusChanges += [PSCustomObject]@{
                    Date = [DateTime]::Parse($history.created)
                    From = $item.fromString
                    To = $item.toString
                    Author = $history.author.displayName
                }
            }
        }
    }

    # Sort by date
    $statusChanges = $statusChanges | Sort-Object Date

    Write-Host "`n=== Status Changes ===" -ForegroundColor Cyan
    $statusChanges | Format-Table Date, From, To, Author -AutoSize

    # Calculate time in each retrospective-related status
    $statuses = @("Solved", "Retrospective In Progress", "Retrospective Completed")
    $statusMetrics = @{}

    foreach ($status in $statuses) {
        $statusMetrics[$status] = @{
            EntryDate = $null
            ExitDate = $null
            DurationDays = 0
            DurationHours = 0
        }
    }

    # Process status changes
    for ($i = 0; $i -lt $statusChanges.Count; $i++) {
        $change = $statusChanges[$i]

        # Check if entering a tracked status
        if ($statuses -contains $change.To) {
            $statusMetrics[$change.To].EntryDate = $change.Date
        }

        # Check if exiting a tracked status
        if ($statuses -contains $change.From) {
            $statusMetrics[$change.From].ExitDate = $change.Date
        }
    }

    # If still in a tracked status, use current time as exit date
    $currentStatus = $response.fields.status.name
    if ($statuses -contains $currentStatus) {
        $statusMetrics[$currentStatus].ExitDate = Get-Date
    }

    # Calculate durations
    Write-Host "`n=== Time in Each Status ===" -ForegroundColor Cyan

    foreach ($status in $statuses) {
        $metric = $statusMetrics[$status]

        if ($metric.EntryDate) {
            $exitDate = if ($metric.ExitDate) { $metric.ExitDate } else { Get-Date }
            $duration = $exitDate - $metric.EntryDate

            $metric.DurationDays = [math]::Round($duration.TotalDays, 2)
            $metric.DurationHours = [math]::Round($duration.TotalHours, 2)

            Write-Host "`n$status" -ForegroundColor Yellow
            Write-Host "  Entry: $($metric.EntryDate.ToString('yyyy-MM-dd HH:mm:ss'))"
            Write-Host "  Exit:  $(if ($metric.ExitDate) { $metric.ExitDate.ToString('yyyy-MM-dd HH:mm:ss') } else { 'Still in this status' })"
            Write-Host "  Duration: $($metric.DurationDays) days ($($metric.DurationHours) hours)" -ForegroundColor Green
        } else {
            Write-Host "`n$status" -ForegroundColor Yellow
            Write-Host "  Status not entered" -ForegroundColor Gray
        }
    }

    # Export to CSV
    $outputFile = "retrospectives/data/$IssueKey-status-metrics.csv"
    $csvData = @()

    foreach ($status in $statuses) {
        $metric = $statusMetrics[$status]
        $csvData += [PSCustomObject]@{
            Issue = $IssueKey
            Status = $status
            EntryDate = if ($metric.EntryDate) { $metric.EntryDate.ToString('yyyy-MM-dd HH:mm:ss') } else { 'N/A' }
            ExitDate = if ($metric.ExitDate) { $metric.ExitDate.ToString('yyyy-MM-dd HH:mm:ss') } else { 'Still in status' }
            DurationDays = $metric.DurationDays
            DurationHours = $metric.DurationHours
        }
    }

    $csvData | Export-Csv -Path $outputFile -NoTypeInformation
    Write-Host "`n✓ Data exported to: $outputFile" -ForegroundColor Green

} catch {
    Write-Host "`n✗ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host $_.Exception.Response.StatusCode
}
