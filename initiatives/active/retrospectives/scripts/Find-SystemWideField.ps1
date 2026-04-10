# Find the System-wide impact field

param([string]$IssueKey = "RDINC-67391")

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

$url = "https://outsystemsrd.atlassian.net/rest/api/3/issue/$IssueKey"
$issue = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

Write-Host "=== Searching for System-wide impact field ===" -ForegroundColor Cyan
Write-Host ""

# Save to JSON for manual inspection
$jsonFile = "issue-$IssueKey-fields.json"
$issue.fields | ConvertTo-Json -Depth 10 | Out-File -FilePath $jsonFile

Write-Host "Full fields saved to: $jsonFile"
Write-Host ""

# Search for likely fields
Write-Host "Checking custom fields with 'Yes' value..." -ForegroundColor Yellow

foreach ($field in $issue.fields.PSObject.Properties) {
    $name = $field.Name
    $value = $field.Value

    if ($null -ne $value) {
        # Check if it's a simple Yes/No field
        if ($value -eq "Yes" -or $value -eq "No") {
            Write-Host "  Found: $name = $value" -ForegroundColor Green
        }

        # Check if it's an object with a value property
        if ($value -is [PSCustomObject] -and $value.PSObject.Properties.Name -contains "value") {
            if ($value.value -eq "Yes" -or $value.value -eq "No") {
                Write-Host "  Found: $name = $($value.value)" -ForegroundColor Green
            }
        }
    }
}

Write-Host ""
Write-Host "Please check $jsonFile and search for 'System-wide' or 'impact'" -ForegroundColor Cyan
