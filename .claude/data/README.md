# Data Files

This folder contains cached data files used by EngineeringOS skills.

## automation-rules.json

**Required by:** `/audit-jira-field` skill

**Purpose:** Cache of Jira automation rules exported from your Jira instance. Used to check if fields are used in automations before making changes.

**How to obtain:**

1. Go to your Jira instance
2. Navigate to: **Settings → System → Automation**
3. Click **Export** button
4. Save as **JSON** format
5. Copy the downloaded file to: `.claude/data/automation-rules.json`

**Permissions required:** Jira Administrator or Automation Administrator

**Update frequency:** Export new version when automation rules change (recommend monthly or before major field changes).

**Security:** This file is excluded from Git (see `.gitignore`) as it contains sensitive company data.

---

## Files in this folder

| File | Purpose | Update Frequency |
|------|---------|------------------|
| `automation-rules.json` | Jira automation rules cache | Monthly or on-demand |

---

**Note:** If `automation-rules.json` is missing, the `/audit-jira-field` skill will fall back to searching `C:\Users\ios\Downloads\automation-rules-*.json` for the most recent export.
