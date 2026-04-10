<#
.SYNOPSIS
    Calculate retrospective metrics for RDINC issues

.PARAMETER IssueKeys
    Array of issue keys to process

.EXAMPLE
    .\Get-RetroMetrics.ps1 -IssueKeys @("RDINC-67391", "RDINC-67392")
#>

param(
    [Parameter(Mandatory=$true)]
    [string[]]$IssueKeys
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

$pair = "$($email):$($token)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$headers = @{
    Authorization = "Basic $encodedCreds"
    "Content-Type" = "application/json"
}

$baseUrl = "https://outsystemsrd.atlassian.net"

Write-Host ""
Write-Host "=== Retrospective Metrics Calculator ===" -ForegroundColor Cyan
Write-Host "Processing $($IssueKeys.Count) issue(s)..." -ForegroundColor Gray
Write-Host ""

$allResults = @()

foreach ($issueKey in $IssueKeys) {
    Write-Host "Analyzing $issueKey..." -ForegroundColor Yellow

    try {
        # Get issue with changelog
        $url = "$baseUrl/rest/api/3/issue/$issueKey`?expand=changelog"
        $issue = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

        Write-Host "  Status: $($issue.fields.status.name)" -ForegroundColor Green
        Write-Host "  Changelog entries: $($issue.changelog.histories.Count)"

        # Extract status changes
        $statusChanges = @()
        foreach ($history in $issue.changelog.histories) {
            foreach ($item in $history.items) {
                if ($item.field -eq "status") {
                    $statusChanges += [PSCustomObject]@{
                        Date = [DateTime]::Parse($history.created)
                        FromStatus = $item.fromString
                        ToStatus = $item.toString
                        Author = $history.author.displayName
                    }
                }
            }
        }

        # Sort by date
        $statusChanges = $statusChanges | Sort-Object Date

        Write-Host "  Status transitions: $($statusChanges.Count)"

        # Track the three key statuses
        $trackedStatuses = @("Solved", "Retrospective In Progress", "Retrospective Completed")
        $statusTiming = @{}

        foreach ($status in $trackedStatuses) {
            $statusTiming[$status] = @{
                EntryDate = $null
                ExitDate = $null
            }
        }

        # Process transitions
        foreach ($change in $statusChanges) {
            # Entering a tracked status
            if ($trackedStatuses -contains $change.ToStatus) {
                if ($null -eq $statusTiming[$change.ToStatus].EntryDate) {
                    $statusTiming[$change.ToStatus].EntryDate = $change.Date
                }
            }

            # Exiting a tracked status
            if ($trackedStatuses -contains $change.FromStatus) {
                $statusTiming[$change.FromStatus].ExitDate = $change.Date
            }
        }

        # If currently in a tracked status, use now as exit
        $currentStatus = $issue.fields.status.name
        if ($trackedStatuses -contains $currentStatus) {
            $statusTiming[$currentStatus].ExitDate = Get-Date
        }

        # Calculate durations and create results
        foreach ($status in $trackedStatuses) {
            $timing = $statusTiming[$status]

            if ($null -ne $timing.EntryDate) {
                $exitDate = if ($null -ne $timing.ExitDate) { $timing.ExitDate } else { Get-Date }
                $duration = $exitDate - $timing.EntryDate

                $allResults += [PSCustomObject]@{
                    Issue = $issueKey
                    Summary = $issue.fields.summary
                    CurrentStatus = $currentStatus
                    MeasuredStatus = $status
                    EntryDate = $timing.EntryDate.ToString('yyyy-MM-dd HH:mm:ss')
                    ExitDate = if ($null -ne $timing.ExitDate) { $timing.ExitDate.ToString('yyyy-MM-dd HH:mm:ss') } else { 'In Progress' }
                    DurationDays = [math]::Round($duration.TotalDays, 2)
                    DurationHours = [math]::Round($duration.TotalHours, 2)
                }

                Write-Host "  $status`: $([math]::Round($duration.TotalDays, 2)) days" -ForegroundColor Cyan
            } else {
                $allResults += [PSCustomObject]@{
                    Issue = $issueKey
                    Summary = $issue.fields.summary
                    CurrentStatus = $currentStatus
                    MeasuredStatus = $status
                    EntryDate = 'N/A'
                    ExitDate = 'N/A'
                    DurationDays = 0
                    DurationHours = 0
                }
                Write-Host "  $status`: Not entered" -ForegroundColor Gray
            }
        }

        Write-Host ""

    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
    }

    Start-Sleep -Milliseconds 500
}

# Export results
if ($allResults.Count -gt 0) {
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $dataDir = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\data"
    $outputFile = Join-Path $dataDir "retrospective-metrics-$timestamp.csv"

    $allResults | Export-Csv -Path $outputFile -NoTypeInformation

    Write-Host "=== Summary ===" -ForegroundColor Cyan
    Write-Host "Total issues: $($IssueKeys.Count)" -ForegroundColor Green
    Write-Host "Results saved: $outputFile" -ForegroundColor Green
    Write-Host ""

    Write-Host "=== Results Preview ===" -ForegroundColor Cyan
    $allResults | Format-Table Issue, MeasuredStatus, DurationDays, DurationHours -AutoSize
} else {
    Write-Host "No results to export" -ForegroundColor Red
}
