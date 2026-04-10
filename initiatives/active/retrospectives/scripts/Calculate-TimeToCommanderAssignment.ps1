# Calculate time from Solved to Retrospective Commander assignment

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
Write-Host "=== Time from Solved to Retrospective Commander Assignment ===" -ForegroundColor Cyan
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

        # Find when Retrospective Commander was assigned
        $commanderDate = $null
        $commanderName = $null
        foreach ($history in $issue.changelog.histories) {
            foreach ($item in $history.items) {
                if ($item.field -eq "Retrospective Commander" -and $item.toString) {
                    $commanderDate = [DateTime]::Parse($history.created)
                    $commanderName = $item.toString
                    break
                }
            }
            if ($commanderDate) { break }
        }

        if ($solvedDate -and $commanderDate) {
            $duration = $commanderDate - $solvedDate
            $durationDays = [math]::Round($duration.TotalDays, 2)
            $durationHours = [math]::Round($duration.TotalHours, 2)

            Write-Host "  Solved: $($solvedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Commander Assigned: $($commanderDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Time to Assignment: $durationDays days" -ForegroundColor Green

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                SolvedDate = $solvedDate.ToString('yyyy-MM-dd HH:mm:ss')
                CommanderAssignedDate = $commanderDate.ToString('yyyy-MM-dd HH:mm:ss')
                CommanderName = $commanderName
                DurationDays = $durationDays
                DurationHours = $durationHours
            }
        } elseif ($solvedDate -and -not $commanderDate) {
            Write-Host "  Solved: $($solvedDate.ToString('yyyy-MM-dd HH:mm'))" -ForegroundColor Gray
            Write-Host "  Commander: Not assigned" -ForegroundColor Red

            $results += [PSCustomObject]@{
                Issue = $issueKey
                Summary = $issue.fields.summary
                SolvedDate = $solvedDate.ToString('yyyy-MM-dd HH:mm:ss')
                CommanderAssignedDate = "Not assigned"
                CommanderName = "N/A"
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
    $assigned = $results | Where-Object { $_.DurationDays -gt 0 }

    Write-Host "=== Summary Statistics ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Total issues: $($results.Count)"
    Write-Host "Issues with commander assigned: $($assigned.Count)" -ForegroundColor Green
    Write-Host "Issues without commander: $($results.Count - $assigned.Count)" -ForegroundColor Yellow
    Write-Host ""

    if ($assigned.Count -gt 0) {
        $avg = ($assigned | Measure-Object -Property DurationDays -Average).Average
        $median = ($assigned | Sort-Object DurationDays)[[math]::Floor($assigned.Count / 2)].DurationDays
        $min = ($assigned | Measure-Object -Property DurationDays -Minimum).Minimum
        $max = ($assigned | Measure-Object -Property DurationDays -Maximum).Maximum

        Write-Host "Time to Commander Assignment:" -ForegroundColor Yellow
        Write-Host "  Average: $([math]::Round($avg, 2)) days" -ForegroundColor Cyan
        Write-Host "  Median: $([math]::Round($median, 2)) days" -ForegroundColor Cyan
        Write-Host "  Min: $([math]::Round($min, 2)) days" -ForegroundColor Cyan
        Write-Host "  Max: $([math]::Round($max, 2)) days" -ForegroundColor Cyan
        Write-Host ""
    }

    # Save to CSV
    $outputDir = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\data"
    $outputFile = Join-Path $outputDir "time-to-commander-assignment-$(Get-Date -Format 'yyyyMMdd-HHmmss').csv"
    $results | Export-Csv -Path $outputFile -NoTypeInformation

    Write-Host "Results saved to:" -ForegroundColor Green
    Write-Host $outputFile
    Write-Host ""

    # Display table
    Write-Host "=== Detailed Results ===" -ForegroundColor Cyan
    $results | Sort-Object DurationDays -Descending | Format-Table Issue, DurationDays, CommanderName -AutoSize
}
