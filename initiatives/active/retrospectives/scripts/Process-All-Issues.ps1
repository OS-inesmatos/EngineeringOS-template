# Process all issues from file

$issues = Get-Content 'issues-list.txt'

Write-Host ""
Write-Host "=== Processing $($issues.Count) issues ===" -ForegroundColor Cyan
Write-Host ""

& './Get-RetroMetrics.ps1' -IssueKeys $issues
