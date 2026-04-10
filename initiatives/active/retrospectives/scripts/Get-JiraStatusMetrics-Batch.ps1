<#
.SYNOPSIS
    Batch process multiple Jira issues to calculate retrospective metrics

.DESCRIPTION
    Retrieves status history for multiple RDINC issues and calculates time spent
    in Solved, Retrospective In Progress, and Retrospective Completed statuses.

    Results are exported to individual CSV files and a consolidated report.

.PARAMETER IssueKeys
    Array of Jira issue keys to process (e.g., @("RDINC-67391", "RDINC-67392"))

.PARAMETER InputFile
    Path to a text file containing one issue key per line

.EXAMPLE
    .\Get-JiraStatusMetrics-Batch.ps1 -IssueKeys @("RDINC-67391", "RDINC-67392")

.EXAMPLE
    .\Get-JiraStatusMetrics-Batch.ps1 -InputFile "issues.txt"
#>

param(
    [Parameter(Mandatory=$false)]
    [string[]]$IssueKeys,

    [Parameter(Mandatory=$false)]
    [string]$InputFile
)

# Load credentials
function Get-StoredJiraCredentials {
    $credPath = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\.credentials"
    $emailPath = Join-Path $credPath "jira-email.txt"
    $tokenPath = Join-Path $credPath "jira-token.txt"

    if (-not (Test-Path $emailPath) -or -not (Test-Path $tokenPath)) {
        throw "Credentials not found! Please run Setup-JiraCredentials.ps1 first."
    }

    $email = Get-Content $emailPath
    $tokenSecure = Get-Content $tokenPath | ConvertTo-SecureString
    $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($tokenSecure)
    )

    return @{
        Email = $email
        Token = $token
    }
}

# Get issue status metrics
function Get-IssueStatusMetrics {
    param(
        [string]$IssueKey,
        [hashtable]$Credentials
    )

    $JiraBaseUrl = "https://outsystemsrd.atlassian.net"
    $ApiUrl = "$JiraBaseUrl/rest/api/3/issue/$IssueKey?expand=changelog"

    # Create authentication header
    $pair = "$($Credentials.Email):$($Credentials.Token)"
    $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
    $headers = @{
        Authorization = "Basic $encodedCreds"
        "Content-Type" = "application/json"
    }

    try {
        $response = Invoke-RestMethod -Uri $ApiUrl -Method Get -Headers $headers

        Write-Host "  ✓ $IssueKey - $($response.fields.status.name)" -ForegroundColor Green

        # Extract status changes from changelog
        $statusChanges = @()

        foreach ($history in $response.changelog.histories) {
            foreach ($item in $history.items) {
                if ($item.field -eq "status") {
                    $statusChanges += [PSCustomObject]@{
                        Date = [DateTime]::Parse($history.created)
                        From = $item.fromString
                        To = $item.toString
                    }
                }
            }
        }

        # Sort by date
        $statusChanges = $statusChanges | Sort-Object Date

        # Calculate time in each retrospective-related status
        $statuses = @("Solved", "Retrospective In Progress", "Retrospective Completed")
        $statusMetrics = @{}

        foreach ($status in $statuses) {
            $statusMetrics[$status] = @{
                EntryDate = $null
                ExitDate = $null
            }
        }

        # Process status changes
        for ($i = 0; $i -lt $statusChanges.Count; $i++) {
            $change = $statusChanges[$i]

            # Check if entering a tracked status
            if ($statuses -contains $change.To) {
                if (-not $statusMetrics[$change.To].EntryDate) {
                    $statusMetrics[$change.To].EntryDate = $change.Date
                }
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

        # Build result objects
        $results = @()
        foreach ($status in $statuses) {
            $metric = $statusMetrics[$status]

            if ($metric.EntryDate) {
                $exitDate = if ($metric.ExitDate) { $metric.ExitDate } else { Get-Date }
                $duration = $exitDate - $metric.EntryDate

                $results += [PSCustomObject]@{
                    Issue = $IssueKey
                    Summary = $response.fields.summary
                    CurrentStatus = $response.fields.status.name
                    MeasuredStatus = $status
                    EntryDate = $metric.EntryDate.ToString('yyyy-MM-dd HH:mm:ss')
                    ExitDate = if ($metric.ExitDate) { $metric.ExitDate.ToString('yyyy-MM-dd HH:mm:ss') } else { 'In Progress' }
                    DurationDays = [math]::Round($duration.TotalDays, 2)
                    DurationHours = [math]::Round($duration.TotalHours, 2)
                }
            } else {
                $results += [PSCustomObject]@{
                    Issue = $IssueKey
                    Summary = $response.fields.summary
                    CurrentStatus = $response.fields.status.name
                    MeasuredStatus = $status
                    EntryDate = 'N/A'
                    ExitDate = 'N/A'
                    DurationDays = 0
                    DurationHours = 0
                }
            }
        }

        return $results

    } catch {
        Write-Host "  ✗ $IssueKey - Error: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

# Main execution
Write-Host ""
Write-Host "=== Jira Retrospective Metrics - Batch Processing ===" -ForegroundColor Cyan

# Get issue keys from input file if provided
if ($InputFile) {
    if (Test-Path $InputFile) {
        $IssueKeys = Get-Content $InputFile | Where-Object { $_ -match '\S' }
        Write-Host "Loaded $($IssueKeys.Count) issues from $InputFile"
        Write-Host ""
    } else {
        Write-Host "✗ File not found: $InputFile" -ForegroundColor Red
        exit 1
    }
}

if (-not $IssueKeys -or $IssueKeys.Count -eq 0) {
    Write-Host "✗ No issue keys provided. Use -IssueKeys or -InputFile parameter." -ForegroundColor Red
    exit 1
}

# Load credentials
Write-Host "Loading credentials..." -ForegroundColor Gray
try {
    $creds = Get-StoredJiraCredentials
    Write-Host "✓ Credentials loaded" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "✗ $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Run Setup-JiraCredentials.ps1 first to store your credentials." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Process issues
Write-Host "Processing $($IssueKeys.Count) issues..." -ForegroundColor Cyan
Write-Host ""

$allResults = @()

foreach ($issueKey in $IssueKeys) {
    $results = Get-IssueStatusMetrics -IssueKey $issueKey -Credentials $creds

    if ($results) {
        $allResults += $results
    }

    Start-Sleep -Milliseconds 500  # Rate limiting
}

# Export consolidated results
if ($allResults.Count -gt 0) {
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $outputFile = "retrospectives/data/retrospective-metrics-$timestamp.csv"

    $allResults | Export-Csv -Path $outputFile -NoTypeInformation

    Write-Host ""
    Write-Host "=== Summary ===" -ForegroundColor Cyan
    Write-Host "Total issues processed: $($IssueKeys.Count)" -ForegroundColor Green
    Write-Host "Results exported to: $outputFile" -ForegroundColor Green
    Write-Host ""

    # Display summary table
    Write-Host "=== Results Preview ===" -ForegroundColor Cyan
    $allResults | Format-Table Issue, MeasuredStatus, DurationDays, DurationHours -AutoSize
} else {
    Write-Host ""
    Write-Host "✗ No results to export" -ForegroundColor Red
}
