# Retrospective Metrics Scripts

PowerShell scripts to measure time spent in retrospective-related statuses for RDINC incidents.

## Quick Start

### 1. One-Time Setup

Store your Jira credentials securely (you only do this once):

```powershell
cd Documents\koda+claude\retrospectives\scripts
.\Setup-JiraCredentials.ps1
```

You'll need:
- Your Jira email: `ines.matos@outsystems.com`
- A Jira API token: Create one at https://id.atlassian.com/manage-profile/security/api-tokens

### 2. Process Issues

**Single issue:**
```powershell
.\Get-JiraStatusMetrics-Batch.ps1 -IssueKeys @("RDINC-67391")
```

**Multiple issues:**
```powershell
.\Get-JiraStatusMetrics-Batch.ps1 -IssueKeys @("RDINC-67391", "RDINC-67392", "RDINC-67393")
```

**From a file:**
```powershell
# Create issues.txt with one issue key per line
.\Get-JiraStatusMetrics-Batch.ps1 -InputFile "issues.txt"
```

## What It Measures

For each RDINC incident with "System-wide impact? = Yes", the script tracks:

1. **Solved** - Time from when incident moved to Solved until assigned to retrospective commander
2. **Retrospective In Progress** - Time from assignment to retro completion
3. **Retrospective Completed** - Time from retro completion until all improvement actions closed

## Output

Results are exported to `retrospectives/data/` as CSV files with:
- Issue key
- Summary
- Current status
- Entry/exit dates for each measured status
- Duration in days and hours

## Files

- **Setup-JiraCredentials.ps1** - One-time credential setup
- **Get-JiraStatusMetrics-Batch.ps1** - Process multiple issues
- **Get-JiraStatusMetrics.ps1** - Original single-issue script (manual credentials)

## Troubleshooting

**Error: Credentials not found**
- Run `Setup-JiraCredentials.ps1` first

**Error: Unauthorized**
- Regenerate your API token
- Run `Setup-JiraCredentials.ps1` again

**No data for a status**
- The issue never entered that status
- Check if "System-wide impact? = Yes" on the issue
