# Inspect all fields of an issue to find System-wide impact

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

Write-Host "=== All Fields for $IssueKey ===" -ForegroundColor Cyan
Write-Host ""

foreach ($field in $issue.fields.PSObject.Properties) {
    $name = $field.Name
    $value = $field.Value

    # Look for fields that might be System-wide impact
    if ($name -match "custom|impact|system|wide" -or
        ($value -and $value.ToString() -match "system|wide|impact|Yes|No")) {

        Write-Host "Field: $name" -ForegroundColor Yellow
        Write-Host "Value: $value"
        Write-Host "Type: $($value.GetType().Name)"

        if ($value -is [PSCustomObject]) {
            Write-Host "Properties:"
            $value.PSObject.Properties | ForEach-Object {
                Write-Host "  $($_.Name): $($_.Value)"
            }
        }

        Write-Host ""
    }
}
