$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$credPath = Join-Path $scriptDir "..\.credentials"
$emailPath = Join-Path $credPath "jira-email.txt"
$tokenPath = Join-Path $credPath "jira-token.txt"

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
$testIssue = "RDINC-72566"

try {
    $url = "$baseUrl/rest/api/3/issue/$testIssue"
    $issue = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

    Write-Host ""
    Write-Host "=== All Custom Fields on $testIssue ===" -ForegroundColor Cyan
    Write-Host ""

    $customFields = @()
    foreach ($prop in $issue.fields.PSObject.Properties) {
        if ($prop.Name -match "^customfield_") {
            $fieldName = if ($issue.names.($prop.Name)) { $issue.names.($prop.Name) } else { "N/A" }
            $fieldValue = $prop.Value

            $customFields += [PSCustomObject]@{
                FieldId = $prop.Name
                FieldName = $fieldName
                Value = if ($fieldValue) { $fieldValue.ToString().Substring(0, [Math]::Min(50, $fieldValue.ToString().Length)) } else { "(empty)" }
            }
        }
    }

    $customFields | Sort-Object FieldName | Format-Table -AutoSize

    Write-Host ""
    Write-Host "=== Searching for Review/RCA related fields ===" -ForegroundColor Yellow
    $customFields | Where-Object { $_.FieldName -match "review|rca|readout|presentation" -and $_.FieldName -ne "N/A" } | Format-Table -AutoSize

} catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
}
