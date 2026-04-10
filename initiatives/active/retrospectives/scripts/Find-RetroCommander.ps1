# Find Retrospective Commander field and calculate time to assignment

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
Write-Host "=== Finding Retrospective Commander Field ===" -ForegroundColor Cyan
Write-Host ""

# Get field list
$fields = Invoke-RestMethod -Uri "$baseUrl/rest/api/3/field" -Method Get -Headers $headers

$commanderFields = $fields | Where-Object { $_.name -match "commander|lead" -and $_.name -match "retro" }

if ($commanderFields) {
    Write-Host "Found Retrospective Commander fields:" -ForegroundColor Green
    $commanderFields | ForEach-Object {
        Write-Host "  $($_.id) - $($_.name)"
    }
} else {
    Write-Host "No exact match. Searching for similar fields..." -ForegroundColor Yellow
    $fields | Where-Object { $_.name -match "retro" } | ForEach-Object {
        Write-Host "  $($_.id) - $($_.name)"
    }
}

Write-Host ""
Write-Host "Checking RDINC-67391 for field values..." -ForegroundColor Cyan

$issue = Invoke-RestMethod -Uri "$baseUrl/rest/api/3/issue/RDINC-67391?expand=changelog" -Method Get -Headers $headers

# Look for fields with user assignments
Write-Host ""
Write-Host "Fields with user/person values:" -ForegroundColor Yellow
foreach ($field in $issue.fields.PSObject.Properties) {
    $value = $field.Value
    if ($value -and $value -is [PSCustomObject] -and $value.PSObject.Properties.Name -contains "displayName") {
        Write-Host "  $($field.Name) = $($value.displayName)"
    }
}

# Check changelog for field assignments
Write-Host ""
Write-Host "Checking changelog for retrospective-related assignments..." -ForegroundColor Cyan
foreach ($history in $issue.changelog.histories) {
    foreach ($item in $history.items) {
        if ($item.field -match "retro|commander|lead" -or
            ($item.toString -and $item.toString -match "retro|commander")) {
            Write-Host ""
            Write-Host "Date: $($history.created)" -ForegroundColor Green
            Write-Host "Field: $($item.field)"
            Write-Host "From: $($item.fromString)"
            Write-Host "To: $($item.toString)"
            Write-Host "Author: $($history.author.displayName)"
        }
    }
}
