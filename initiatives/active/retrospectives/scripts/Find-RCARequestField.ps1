# Find RCA Request Date/Time field

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

Write-Host ""
Write-Host "=== Finding RCA Request Date/Time Field ===" -ForegroundColor Cyan
Write-Host ""

# Get all fields
$fields = Invoke-RestMethod -Uri "$baseUrl/rest/api/3/field" -Method Get -Headers $headers

# Search for RCA-related date fields
Write-Host "RCA-related date/time fields:" -ForegroundColor Yellow
$rcaFields = $fields | Where-Object { $_.name -match "RCA|request" -and $_.name -match "date|time" }

if ($rcaFields) {
    $rcaFields | ForEach-Object {
        Write-Host "  $($_.id) - $($_.name)" -ForegroundColor Green
    }
} else {
    Write-Host "No exact match. Searching all RCA fields..." -ForegroundColor Gray
    $fields | Where-Object { $_.name -match "RCA" } | ForEach-Object {
        Write-Host "  $($_.id) - $($_.name)"
    }
}

Write-Host ""
Write-Host "Checking RDINC-67391 changelog for RCA-related changes..." -ForegroundColor Cyan

$issue = Invoke-RestMethod -Uri "$baseUrl/rest/api/3/issue/RDINC-67391?expand=changelog" -Method Get -Headers $headers

Write-Host ""
Write-Host "RCA-related changes in changelog:" -ForegroundColor Yellow
foreach ($history in $issue.changelog.histories) {
    foreach ($item in $history.items) {
        if ($item.field -match "RCA|request|present" -or
            $item.fieldtype -match "datetime" -and $item.field -match "RCA") {
            Write-Host ""
            Write-Host "Date: $($history.created)" -ForegroundColor Green
            Write-Host "Field: $($item.field) ($($item.fieldtype))"
            Write-Host "From: $($item.fromString)"
            Write-Host "To: $($item.toString)"
        }
    }
}

Write-Host ""
Write-Host "Date/time fields in RDINC-67391:" -ForegroundColor Yellow
foreach ($field in $issue.fields.PSObject.Properties) {
    $value = $field.Value
    if ($field.Name -match "RCA" -or ($field.Name -match "custom" -and $value -match "\d{2}/\w{3}/\d{2}")) {
        Write-Host "  $($field.Name) = $value"
    }
}
