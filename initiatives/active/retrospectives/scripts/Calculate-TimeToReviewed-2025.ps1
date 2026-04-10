# Calculate time from RCA Request Date/Time (readout) to "Reviewed?" = Yes
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
Write-Host "=== Time from RCA Readout to Reviewed? = Yes (2025 Analysis) ===" -ForegroundColor Cyan
Write-Host "Analyzing $($issues.Count) issues from 2025..." -ForegroundColor Gray
Write-Host ""

# Field IDs (found via /rest/api/3/field)
$reviewedFieldId = "customfield_17853"  # "Reviewed?"
$rcaFieldId = "customfield_16357"       # "RCA Request Date/Time"

Write-Host "Using field IDs:" -ForegroundColor Green
Write-Host "  RCA Request Date/Time: $rcaFieldId" -ForegroundColor Gray
Write-Host "  Reviewed?: $reviewedFieldId" -ForegroundColor Gray
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

        # Get RCA Request Date/Time
        $rcaRequestDateTime = $null
        $rcaFieldValue = $issue.fields.$rcaFieldId

        if ($rcaFieldValue) {
            try {
                if ($rcaFieldValue -match "^\d{4}-\d{2}-\d{2}T") {
                    $rcaRequestDateTime = [DateTime]::Parse($rcaFieldValue)
                } else {
                    $rcaRequestDateTime = [DateTime]::ParseExact($rcaFieldValue, "dd/MMM/yy h:mm tt", [System.Globalization.CultureInfo]::InvariantCulture)
                }
            } catch {
                Write-Host "  Warning: Could not parse RCA date: $rcaFieldValue" -ForegroundColor Gray
            }
        }

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

        if ($rcaRequestDateTime -and $reviewedDate) {
            $duration = $reviewedDate - $rcaRequestDateTime
            $durationDays = [math]::Round($duration.TotalDays, 2)
            $durationHours = [math]::Round($duration.TotalHours, 2)

            Write-Host "  RCA Readout: $($rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Reviewed: $($reviewedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Duration: $durationDays days" -ForegroundColor Green

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                RCAReadoutDate = $rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm:ss')
                ReviewedDate = $reviewedDate.ToString('yyyy-MM-dd HH:mm:ss')
                DurationDays = $durationDays
                DurationHours = $durationHours
                Status = "Complete"
            }
        } elseif ($rcaRequestDateTime -and -not $reviewedDate) {
            Write-Host "  RCA Readout: $($rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Reviewed: Not set" -ForegroundColor Yellow

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                RCAReadoutDate = $rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm:ss')
                ReviewedDate = "Not reviewed"
                DurationDays = $null
                DurationHours = $null
                Status = "Missing review"
            }
        } elseif (-not $rcaRequestDateTime) {
            Write-Host "  RCA Readout: Not scheduled" -ForegroundColor Gray

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                RCAReadoutDate = "Not scheduled"
                ReviewedDate = if ($reviewedDate) { $reviewedDate.ToString('yyyy-MM-dd HH:mm:ss') } else { "Not reviewed" }
                DurationDays = $null
                DurationHours = $null
                Status = "No RCA scheduled"
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
    Write-Host "Issues missing RCA date: $(($results | Where-Object { $_.Status -eq 'No RCA scheduled' }).Count)" -ForegroundColor Yellow
    Write-Host "Issues missing review: $(($results | Where-Object { $_.Status -eq 'Missing review' }).Count)" -ForegroundColor Yellow
    Write-Host "Errors: $errorCount" -ForegroundColor Red
    Write-Host ""

    if ($withBothDates.Count -gt 0) {
        $avg = ($withBothDates | Measure-Object -Property DurationDays -Average).Average
        $sorted = $withBothDates | Sort-Object DurationDays
        $median = $sorted[[math]::Floor($sorted.Count / 2)].DurationDays
        $min = ($withBothDates | Measure-Object -Property DurationDays -Minimum).Minimum
        $max = ($withBothDates | Measure-Object -Property DurationDays -Maximum).Maximum

        Write-Host "Time from RCA Readout to Reviewed? = Yes:" -ForegroundColor Yellow
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
    }

    # Save to CSV
    $outputDir = "..\data"
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir | Out-Null
    }

    $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $outputFile = Join-Path $outputDir "time-to-reviewed-2025-$timestamp.csv"
    $results | Export-Csv -Path $outputFile -NoTypeInformation

    Write-Host "Results saved to:" -ForegroundColor Green
    Write-Host $outputFile
    Write-Host ""

    # Top 10 slowest
    Write-Host "=== Top 10 Slowest (Days to Review) ===" -ForegroundColor Cyan
    $withBothDates | Sort-Object DurationDays -Descending | Select-Object -First 10 | Format-Table Issue, DurationDays, RCAReadoutDate, ReviewedDate -AutoSize
}
