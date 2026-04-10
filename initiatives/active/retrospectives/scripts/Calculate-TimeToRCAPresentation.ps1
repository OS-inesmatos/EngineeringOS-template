# Calculate time from Solved to RCA Request Date/Time (presentation)

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

# Read system-wide issues
$issues = Get-Content "issues-system-wide.txt"

Write-Host ""
Write-Host "=== Time from Solved to RCA Presentation (RCA Request Date/Time) ===" -ForegroundColor Cyan
Write-Host "Analyzing $($issues.Count) issues..." -ForegroundColor Gray
Write-Host ""

$results = @()

foreach ($issueKey in $issues) {
    Write-Host "Processing $issueKey..." -ForegroundColor Yellow

    try {
        $url = "$baseUrl/rest/api/3/issue/$issueKey`?expand=changelog"
        $issue = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

        # Find when moved to Solved
        $solvedDate = $null
        foreach ($history in $issue.changelog.histories) {
            foreach ($item in $history.items) {
                if ($item.field -eq "status" -and $item.toString -eq "Solved") {
                    $solvedDate = [DateTime]::Parse($history.created)
                    break
                }
            }
            if ($solvedDate) { break }
        }

        # Get RCA Request Date/Time from current field value
        $rcaRequestDateTime = $null
        $rcaFieldValue = $issue.fields.customfield_16357

        if ($rcaFieldValue) {
            try {
                # Try ISO format first (e.g., "2026-02-12T11:00:00.000+0000")
                if ($rcaFieldValue -match "^\d{4}-\d{2}-\d{2}T") {
                    $rcaRequestDateTime = [DateTime]::Parse($rcaFieldValue)
                } else {
                    # Try format like "12/Feb/26 11:00 AM"
                    $rcaRequestDateTime = [DateTime]::ParseExact($rcaFieldValue, "dd/MMM/yy h:mm tt", [System.Globalization.CultureInfo]::InvariantCulture)
                }
            } catch {
                Write-Host "  Warning: Could not parse RCA date: $rcaFieldValue" -ForegroundColor Gray
            }
        }

        if ($solvedDate -and $rcaRequestDateTime) {
            $duration = $rcaRequestDateTime - $solvedDate
            $durationDays = [math]::Round($duration.TotalDays, 2)
            $durationHours = [math]::Round($duration.TotalHours, 2)

            Write-Host "  Solved: $($solvedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  RCA Presentation: $($rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Time to Presentation: $durationDays days" -ForegroundColor Green

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                SolvedDate = $solvedDate.ToString('yyyy-MM-dd HH:mm:ss')
                RCAPresentationDate = $rcaRequestDateTime.ToString('yyyy-MM-dd HH:mm:ss')
                DurationDays = $durationDays
                DurationHours = $durationHours
            }
        } elseif ($solvedDate -and -not $rcaRequestDateTime) {
            Write-Host "  Solved: $($solvedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  RCA Presentation: Not scheduled/completed" -ForegroundColor Red

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                SolvedDate = $solvedDate.ToString('yyyy-MM-dd HH:mm:ss')
                RCAPresentationDate = "Not set"
                DurationDays = 0
                DurationHours = 0
            }
        } else {
            Write-Host "  No Solved status found" -ForegroundColor Gray
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
    $withPresentation = $results | Where-Object { $_.DurationDays -ne 0 }

    Write-Host "=== Summary Statistics ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Total issues: $($results.Count)"
    Write-Host "Issues with RCA presentation scheduled: $($withPresentation.Count)" -ForegroundColor Green
    Write-Host "Issues without RCA presentation: $($results.Count - $withPresentation.Count)" -ForegroundColor Yellow
    Write-Host ""

    if ($withPresentation.Count -gt 0) {
        $avg = ($withPresentation | Measure-Object -Property DurationDays -Average).Average
        $median = ($withPresentation | Sort-Object DurationDays)[[math]::Floor($withPresentation.Count / 2)].DurationDays
        $min = ($withPresentation | Measure-Object -Property DurationDays -Minimum).Minimum
        $max = ($withPresentation | Measure-Object -Property DurationDays -Maximum).Maximum

        Write-Host "Time from Solved to RCA Presentation:" -ForegroundColor Yellow
        Write-Host "  Average: $([math]::Round($avg, 2)) days" -ForegroundColor Cyan
        Write-Host "  Median: $([math]::Round($median, 2)) days" -ForegroundColor Cyan
        Write-Host "  Min: $([math]::Round($min, 2)) days" -ForegroundColor Cyan
        Write-Host "  Max: $([math]::Round($max, 2)) days" -ForegroundColor Cyan
        Write-Host ""
    }

    # Save to CSV
    $outputDir = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\data"
    $outputFile = Join-Path $outputDir "time-to-rca-presentation-$(Get-Date -Format 'yyyyMMdd-HHmmss').csv"
    $results | Export-Csv -Path $outputFile -NoTypeInformation

    Write-Host "Results saved to:" -ForegroundColor Green
    Write-Host $outputFile
    Write-Host ""

    # Display table
    Write-Host "=== Detailed Results ===" -ForegroundColor Cyan
    $results | Sort-Object DurationDays -Descending | Format-Table Issue, DurationDays, RCAPresentationDate -AutoSize
}
