# Calculate time from RCA Request Date/Time (readout) to "Reviewed?" = Yes

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

$pair = "${email}:${token}"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$headers = @{
    Authorization = "Basic $encodedCreds"
    "Content-Type" = "application/json"
}

$baseUrl = "https://outsystemsrd.atlassian.net"

# Read system-wide issues
$issuesFile = "issues-system-wide.txt"
if (-not (Test-Path $issuesFile)) {
    Write-Host "ERROR: $issuesFile not found" -ForegroundColor Red
    exit 1
}

$issues = Get-Content $issuesFile

Write-Host ""
Write-Host "=== Time from RCA Readout to Reviewed? = Yes ===" -ForegroundColor Cyan
Write-Host "Analyzing $($issues.Count) issues..." -ForegroundColor Gray
Write-Host ""

# First, find the field ID for "Reviewed?" by checking a sample issue
Write-Host "Finding 'Reviewed?' field ID..." -ForegroundColor Yellow

# Field IDs (found via /rest/api/3/field)
$reviewedFieldId = "customfield_17853"  # "Reviewed?"
$rcaFieldId = "customfield_16357"       # "RCA Request Date/Time"

Write-Host "Using field IDs:" -ForegroundColor Green
Write-Host "  RCA Request Date/Time: $rcaFieldId" -ForegroundColor Gray
Write-Host "  Reviewed?: $reviewedFieldId" -ForegroundColor Gray

Write-Host ""

$results = @()

foreach ($issueKey in $issues) {
    Write-Host "Processing $issueKey..." -ForegroundColor Yellow

    try {
        $url = "$baseUrl/rest/api/3/issue/$issueKey`?expand=changelog,names"
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
                if ($item.field -eq $reviewedFieldId -or $item.fieldId -eq $reviewedFieldId) {
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
            Write-Host "  Reviewed? = Yes: $($reviewedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Time to Review: $durationDays days" -ForegroundColor Green

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                RCAReadoutDate = $rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm:ss')
                ReviewedDate = $reviewedDate.ToString('yyyy-MM-dd HH:mm:ss')
                DurationDays = $durationDays
                DurationHours = $durationHours
            }
        } elseif ($rcaRequestDateTime -and -not $reviewedDate) {
            Write-Host "  RCA Readout: $($rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Reviewed? = Yes: Not set" -ForegroundColor Red

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                RCAReadoutDate = $rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm:ss')
                ReviewedDate = "Not reviewed"
                DurationDays = $null
                DurationHours = $null
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
            }
        }

        Write-Host ""

    } catch {
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
    }

    Start-Sleep -Milliseconds 500
}

# Calculate statistics
if ($results.Count -gt 0) {
    $withBothDates = $results | Where-Object { $_.DurationDays -ne $null }

    Write-Host "=== Summary Statistics ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Total issues: $($results.Count)"
    Write-Host "Issues with both dates: $($withBothDates.Count)" -ForegroundColor Green
    Write-Host "Issues missing dates: $($results.Count - $withBothDates.Count)" -ForegroundColor Yellow
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
    }

    # Save to CSV
    $outputDir = "..\data"
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir | Out-Null
    }

    $outputFile = Join-Path $outputDir "time-to-reviewed-$(Get-Date -Format 'yyyyMMdd-HHmmss').csv"
    $results | Export-Csv -Path $outputFile -NoTypeInformation

    Write-Host "Results saved to:" -ForegroundColor Green
    Write-Host $outputFile
    Write-Host ""

    # Display table
    Write-Host "=== Detailed Results ===" -ForegroundColor Cyan
    $results | Sort-Object DurationDays -Descending | Format-Table Issue, DurationDays, RCAReadoutDate, ReviewedDate -AutoSize
}
