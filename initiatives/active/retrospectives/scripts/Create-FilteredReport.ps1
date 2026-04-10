# Create filtered CSV with only System-wide impact issues

$systemWideIssues = Get-Content "issues-system-wide.txt"
$csvPath = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\data\retrospective-metrics-20260311-113839.csv"
$allData = Import-Csv $csvPath

Write-Host ""
Write-Host "=== Creating Filtered Report ===" -ForegroundColor Cyan
Write-Host "System-wide issues: $($systemWideIssues.Count)"
Write-Host "Total rows in CSV: $($allData.Count)"
Write-Host ""

# Filter data
$filteredData = $allData | Where-Object { $systemWideIssues -contains $_.Issue }

Write-Host "Filtered rows: $($filteredData.Count)" -ForegroundColor Green
Write-Host ""

# Save filtered CSV
$outputDir = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\data"
$outputFile = Join-Path $outputDir "retrospective-metrics-system-wide-$(Get-Date -Format 'yyyyMMdd-HHmmss').csv"
$filteredData | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "Filtered CSV saved to:" -ForegroundColor Green
Write-Host $outputFile
Write-Host ""

# Calculate statistics
Write-Host "=== Statistics (System-wide Impact Only) ===" -ForegroundColor Cyan
Write-Host ""

$byStatus = $filteredData | Group-Object MeasuredStatus

foreach ($group in $byStatus) {
    $avg = ($group.Group | Measure-Object -Property DurationDays -Average).Average
    $median = ($group.Group | Sort-Object DurationDays)[[math]::Floor($group.Count / 2)].DurationDays
    $max = ($group.Group | Measure-Object -Property DurationDays -Maximum).Maximum

    Write-Host "$($group.Name):" -ForegroundColor Yellow
    Write-Host "  Average: $([math]::Round($avg, 2)) days"
    Write-Host "  Median: $([math]::Round($median, 2)) days"
    Write-Host "  Max: $([math]::Round($max, 2)) days"
    Write-Host ""
}

# Show summary by issue
Write-Host "=== Summary by Issue ===" -ForegroundColor Cyan
$summary = $filteredData | Group-Object Issue | ForEach-Object {
    $solved = ($_.Group | Where-Object { $_.MeasuredStatus -eq "Solved" }).DurationDays
    $inProgress = ($_.Group | Where-Object { $_.MeasuredStatus -eq "Retrospective In Progress" }).DurationDays
    $completed = ($_.Group | Where-Object { $_.MeasuredStatus -eq "Retrospective Completed" }).DurationDays
    $total = $solved + $inProgress + $completed

    [PSCustomObject]@{
        Issue = $_.Name
        Solved = [math]::Round($solved, 2)
        InProgress = [math]::Round($inProgress, 2)
        Completed = [math]::Round($completed, 2)
        Total = [math]::Round($total, 2)
    }
} | Sort-Object Total -Descending

$summary | Format-Table -AutoSize

Write-Host "Total issues with System-wide impact: $($summary.Count)" -ForegroundColor Green
