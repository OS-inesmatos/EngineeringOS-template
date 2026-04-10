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

try {
    Write-Host "Fetching all Jira field definitions..." -ForegroundColor Yellow
    $url = "$baseUrl/rest/api/3/field"
    $allFields = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

    Write-Host "Found $($allFields.Count) fields" -ForegroundColor Green
    Write-Host ""

    Write-Host "=== Searching for Review/RCA/Readout related fields ===" -ForegroundColor Cyan
    $relevantFields = $allFields | Where-Object {
        $_.name -match "review|rca|readout|presentation|retrospective" -and
        $_.id -match "customfield_"
    }

    if ($relevantFields.Count -gt 0) {
        $relevantFields | ForEach-Object {
            Write-Host "$($_.id) = $($_.name)" -ForegroundColor Yellow
        }
    } else {
        Write-Host "No matching fields found" -ForegroundColor Red
    }

    Write-Host ""
    Write-Host "Saving all fields to file..." -ForegroundColor Gray
    $allFields | Select-Object id, name, custom, schema |
        Export-Csv -Path "../data/all-jira-fields.csv" -NoTypeInformation
    Write-Host "Saved to: ../data/all-jira-fields.csv" -ForegroundColor Green

} catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
}
