# Calculate time from "Reviewed?" = Yes to "Approved?" = Yes
# For all 115 issues from 2025 retrospective analysis

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

$pair = "${email}:${token}"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$headers = @{
    Authorization = "Basic $encodedCreds"
    "Content-Type" = "application/json"
}

$baseUrl = "https://outsystemsrd.atlassian.net"

# Read 2025 issues
$issuesFile = "issues-2025-retrospectives.txt"
if (-not (Test-Path $issuesFile)) {
    Write-Host "ERROR: $issuesFile not found" -ForegroundColor Red
    exit 1
}

$issues = Get-Content $issuesFile

Write-Host ""
Write-Host "=== Time from Reviewed? = Yes to Approved? = Yes (2025) ===" -ForegroundColor Cyan
Write-Host "Analyzing $($issues.Count) issues from 2025..." -ForegroundColor Gray
Write-Host ""

# Field IDs (found via /rest/api/3/field)
$reviewedFieldId = "customfield_17853"  # "Reviewed?"
$approvedFieldId = "customfield_17854"  # "Approved?"

Write-Host "Using field IDs:" -ForegroundColor Green
Write-Host "  Reviewed?: $reviewedFieldId" -ForegroundColor Gray
Write-Host "  Approved?: $approvedFieldId" -ForegroundColor Gray
Write-Host ""

$results = @()
$processedCount = 0
$errorCount = 0

foreach ($issueKey in $issues) {
    $processedCount++
    Write-Host "[$processedCount/$($issues.Count)] Processing $issueKey..." -ForegroundColor Yellow

    try {
        $url = "$baseUrl/rest/api/3/issue/$issueKey`?expand=changelog"
        $issue = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

        # Find when "Reviewed?" was set to "Yes" in changelog
        $reviewedDate = $null
        foreach ($history in $issue.changelog.histories) {
            foreach ($item in $history.items) {
                if ($item.fieldId -eq $reviewedFieldId) {
                    if ($item.toString -eq "Yes" -or $item.toString -eq "yes") {
                        $reviewedDate = [DateTime]::Parse($history.created)
                        break
                    }
                }
            }
            if ($reviewedDate) { break }
        }

        # Find when "Approved?" was set to "Yes" in changelog
        $approvedDate = $null
        foreach ($history in $issue.changelog.histories) {
            foreach ($item in $history.items) {
                if ($item.fieldId -eq $approvedFieldId) {
                    if ($item.toString -eq "Yes" -or $item.toString -eq "yes") {
                        $approvedDate = [DateTime]::Parse($history.created)
                        break
                    }
                }
            }
            if ($approvedDate) { break }
        }

        if ($reviewedDate -and $approvedDate) {
            $duration = $approvedDate - $reviewedDate
            $durationDays = [math]::Round($duration.TotalDays, 2)
            $durationHours = [math]::Round($duration.TotalHours, 2)
            $durationMinutes = [math]::Round($duration.TotalMinutes, 2)

            Write-Host "  Reviewed: $($reviewedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Approved: $($approvedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Duration: $durationDays days" -ForegroundColor Green

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                ReviewedDate = $reviewedDate.ToString('yyyy-MM-dd HH:mm:ss')
                ApprovedDate = $approvedDate.ToString('yyyy-MM-dd HH:mm:ss')
                DurationDays = $durationDays
                DurationHours = $durationHours
                DurationMinutes = $durationMinutes
                Status = "Complete"
            }
        } elseif ($reviewedDate -and -not $approvedDate) {
            Write-Host "  Reviewed: $($reviewedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Approved: Not set" -ForegroundColor Yellow

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                ReviewedDate = $reviewedDate.ToString('yyyy-MM-dd HH:mm:ss')
                ApprovedDate = "Not approved"
                DurationDays = $null
                DurationHours = $null
                DurationMinutes = $null
                Status = "Missing approval"
            }
        } elseif (-not $reviewedDate) {
            Write-Host "  Reviewed: Not set" -ForegroundColor Gray

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                ReviewedDate = "Not reviewed"
                ApprovedDate = if ($approvedDate) { $approvedDate.ToString('yyyy-MM-dd HH:mm:ss') } else { "Not approved" }
                DurationDays = $null
                DurationHours = $null
                DurationMinutes = $null
                Status = "Not reviewed"
            }
        }

    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }

    # Rate limiting
    if ($processedCount % 10 -eq 0) {
        Write-Host ""
        Write-Host "  Progress: $processedCount/$($issues.Count) ($([math]::Round(($processedCount / $issues.Count) * 100, 1))%)" -ForegroundColor Cyan
        Write-Host ""
        Start-Sleep -Milliseconds 1000
    } else {
        Start-Sleep -Milliseconds 300
    }
}

# Calculate statistics
if ($results.Count -gt 0) {
    $withBothDates = $results | Where-Object { $_.DurationDays -ne $null }

    Write-Host ""
    Write-Host "=== Summary Statistics ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Total issues processed: $($results.Count)" -ForegroundColor Green
    Write-Host "Issues with both dates: $($withBothDates.Count)" -ForegroundColor Green
    Write-Host "Issues missing approval: $(($results | Where-Object { $_.Status -eq 'Missing approval' }).Count)" -ForegroundColor Yellow
    Write-Host "Issues not reviewed: $(($results | Where-Object { $_.Status -eq 'Not reviewed' }).Count)" -ForegroundColor Yellow
    Write-Host "Errors: $errorCount" -ForegroundColor Red
    Write-Host ""

    if ($withBothDates.Count -gt 0) {
        $avg = ($withBothDates | Measure-Object -Property DurationDays -Average).Average
        $sorted = $withBothDates | Sort-Object DurationDays
        $median = $sorted[[math]::Floor($sorted.Count / 2)].DurationDays
        $min = ($withBothDates | Measure-Object -Property DurationDays -Minimum).Minimum
        $max = ($withBothDates | Measure-Object -Property DurationDays -Maximum).Maximum

        Write-Host "Time from Reviewed to Approved:" -ForegroundColor Yellow
        Write-Host "  Average: $([math]::Round($avg, 2)) days" -ForegroundColor Cyan
        Write-Host "  Median: $([math]::Round($median, 2)) days" -ForegroundColor Cyan
        Write-Host "  Min: $([math]::Round($min, 2)) days" -ForegroundColor Cyan
        Write-Host "  Max: $([math]::Round($max, 2)) days" -ForegroundColor Cyan
        Write-Host ""

        # Percentiles
        $p25 = $sorted[[math]::Floor($sorted.Count * 0.25)].DurationDays
        $p75 = $sorted[[math]::Floor($sorted.Count * 0.75)].DurationDays
        $p90 = $sorted[[math]::Floor($sorted.Count * 0.90)].DurationDays

        Write-Host "Percentiles:" -ForegroundColor Yellow
        Write-Host "  P25 (25%): $([math]::Round($p25, 2)) days" -ForegroundColor Cyan
        Write-Host "  P75 (75%): $([math]::Round($p75, 2)) days" -ForegroundColor Cyan
        Write-Host "  P90 (90%): $([math]::Round($p90, 2)) days" -ForegroundColor Cyan
        Write-Host ""

        # Distribution analysis
        $lessThan1Day = ($withBothDates | Where-Object { $_.DurationDays -lt 1 }).Count
        $lessThan1Week = ($withBothDates | Where-Object { $_.DurationDays -lt 7 }).Count
        $lessThan2Weeks = ($withBothDates | Where-Object { $_.DurationDays -lt 14 }).Count
        $moreThan30Days = ($withBothDates | Where-Object { $_.DurationDays -ge 30 }).Count

        Write-Host "Distribution:" -ForegroundColor Yellow
        Write-Host "  < 1 day: $lessThan1Day ($([math]::Round(($lessThan1Day / $withBothDates.Count) * 100, 1))%)" -ForegroundColor Cyan
        Write-Host "  < 1 week: $lessThan1Week ($([math]::Round(($lessThan1Week / $withBothDates.Count) * 100, 1))%)" -ForegroundColor Cyan
        Write-Host "  < 2 weeks: $lessThan2Weeks ($([math]::Round(($lessThan2Weeks / $withBothDates.Count) * 100, 1))%)" -ForegroundColor Cyan
        Write-Host "  >= 30 days: $moreThan30Days ($([math]::Round(($moreThan30Days / $withBothDates.Count) * 100, 1))%)" -ForegroundColor Cyan
        Write-Host ""
    }

    # Save to CSV
    $outputDir = "..\data"
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir | Out-Null
    }

    $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $outputFile = Join-Path $outputDir "time-reviewed-to-approved-2025-$timestamp.csv"
    $results | Export-Csv -Path $outputFile -NoTypeInformation

    Write-Host "Results saved to:" -ForegroundColor Green
    Write-Host $outputFile
    Write-Host ""

    # Top 10 slowest
    Write-Host "=== Top 10 Slowest (Days from Reviewed to Approved) ===" -ForegroundColor Cyan
    $withBothDates | Sort-Object DurationDays -Descending | Select-Object -First 10 | Format-Table Issue, DurationDays, ReviewedDate, ApprovedDate -AutoSize

    # Top 10 fastest
    Write-Host ""
    Write-Host "=== Top 10 Fastest (Days from Reviewed to Approved) ===" -ForegroundColor Cyan
    $withBothDates | Sort-Object DurationDays | Select-Object -First 10 | Format-Table Issue, DurationDays, ReviewedDate, ApprovedDate -AutoSize
}
