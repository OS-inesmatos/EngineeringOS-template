<#
.SYNOPSIS
    One-time setup to store Jira credentials securely

.DESCRIPTION
    Stores your Jira email and API token encrypted on your machine.
    You only need to run this once.

.EXAMPLE
    .\Setup-JiraCredentials.ps1
#>

Write-Host "=== Jira Credentials Setup ===" -ForegroundColor Cyan
Write-Host "This will store your credentials securely on this machine."
Write-Host ""

# Get credentials
$email = Read-Host "Enter your Jira email (e.g., ines.matos@outsystems.com)"
$apiTokenSecure = Read-Host "Enter your Jira API Token" -AsSecureString

# Create credentials directory if it doesn't exist
$credPath = Join-Path $env:USERPROFILE "Documents\koda+claude\retrospectives\.credentials"
New-Item -ItemType Directory -Path $credPath -Force | Out-Null

# Save encrypted credentials
$emailPath = Join-Path $credPath "jira-email.txt"
$tokenPath = Join-Path $credPath "jira-token.txt"

$email | Out-File -FilePath $emailPath -Force
$apiTokenSecure | ConvertFrom-SecureString | Out-File -FilePath $tokenPath -Force

Write-Host ""
Write-Host "Credentials saved securely!" -ForegroundColor Green
Write-Host "Location: $credPath" -ForegroundColor Gray
Write-Host ""
Write-Host "To get your API token, visit:" -ForegroundColor Yellow
Write-Host "https://id.atlassian.com/manage-profile/security/api-tokens"
Write-Host ""
