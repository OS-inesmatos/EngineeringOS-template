---
skill: audit-jira-field
aliases: [audit-field]
description: Check if a Jira field is used in any Jira automations
tags: [jira, automation, governance, audit]
---

# Audit Jira Field Usage in Automations

Check if a specific Jira field is being used in any Jira automation rules. Useful for impact analysis before changing or removing fields.

## Usage

```
/audit-jira-field "Field Name" [--project PROJECT_ID]
/audit-field "Field Name" [--project PROJECT_ID]  # shorter alias
```

**Arguments:**
- `Field Name` (required) - The exact name of the Jira field to search for
- `--project PROJECT_ID` (optional) - Filter results to a specific project ID

**Examples:**
```
/audit-jira-field "Error Code"
/audit-jira-field "Root Cause Categorization" --project 24263
/audit-jira-field "Old Root Cause Categorization"
```

## Instructions

### Step 1: Parse arguments

Extract the field name and optional project ID from the arguments:
- Field name is the first quoted string or first argument
- Project ID follows `--project` flag (if provided)

### Step 2: Locate automation rules file

The automation rules are exported from Jira as JSON. Look for the file in these locations (in order):
1. `.claude/data/automation-rules.json` (project cache - preferred)
2. `C:\Users\ios\Downloads\automation-rules-*.json` (most recent export - fallback)
3. Ask user if file not found

The file is large (~5M tokens), so we cannot read it directly. We must use Python or grep to search it.

**Updating the cache:** When automation rules change, export from Jira (Settings → System → Automation → Export as JSON) and replace `.claude/data/automation-rules.json`.

### Step 3: Search for field usage

Use Python to search the JSON file for the field name. The script should:
1. Load the JSON file
2. Search through all automation rules for the field name (case-insensitive)
3. For each match, extract:
   - Rule name
   - Rule ID
   - Rule state (ENABLED/DISABLED)
   - Projects where the rule applies
   - Trigger type and conditions
   - How the field is used (trigger, condition, action)
   - Smart values that reference the field

### Step 4: Filter by project (if specified)

If `--project` was provided, filter results to only show automations that apply to that project.

Check both:
- `ruleScope.resources[]` - contains project ARIs like `ari:cloud:jira:...:project/24263`
- `trigger.value.eventFilters[]` - may also contain project ARIs

### Step 5: Format and present results

Present results in a clear, actionable format:

```
🔍 Searching for field: "Field Name"
📁 In project: 24263 (if filtered)

✅ Found N automation(s) using this field:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Automation: "Automation Name"
   ID: 12345
   State: ENABLED ⚡ (or DISABLED)

   Projects:
   • Project ID: 24263
   • Project ID: 24362

   Trigger:
   • Type: jira.issue.field.changed
   • When: "Field Name" is updated

   Actions:
   • Copies value to another field
   • Sends notification
   • Assigns to team based on field value

   ⚠️ Impact: This field is critical for [routing/workflow/etc]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Repeat for each automation found]
```

If no automations found:
```
✓ No automations found using field "Field Name"
  Safe to modify or remove this field.
```

### Step 6: Provide context and recommendations

After listing automations, provide analysis:

**If field is used:**
```
⚠️ Impact Analysis:

This field is used in N automation(s):
• X enabled automation(s) will be affected
• Y automation(s) in project 24263

Recommendations:
• Review each automation before changing the field
• Test in non-production environment first
• Consider disabling automations temporarily during migration
• Update automation logic if field name/behavior changes
```

**If field is not used:**
```
✓ Safe to proceed

No active automations depend on this field.
You can safely:
• Rename the field
• Change field type
• Remove the field

Note: Always verify in Jira UI before making changes.
```

## Implementation

Use Python script for robust JSON processing:

```python
import json
import sys
import glob

# Find most recent automation export
files = glob.glob(r'C:\Users\ios\Downloads\automation-rules-*.json')
if not files:
    print("Error: No automation rules file found")
    sys.exit(1)

automation_file = max(files, key=lambda x: x)

# Parse arguments
field_name = sys.argv[1] if len(sys.argv) > 1 else None
project_id = sys.argv[2] if len(sys.argv) > 2 else None

# Load and search JSON
with open(automation_file, 'r', encoding='utf-8') as f:
    data = json.load(f)

# Search for field in all rules
matches = []
for rule in data.get('rules', []):
    rule_str = json.dumps(rule, ensure_ascii=False).lower()
    if field_name.lower() in rule_str:
        # Extract project IDs
        projects = extract_projects(rule)

        # Filter by project if specified
        if project_id and project_id not in projects:
            continue

        matches.append({
            'rule': rule,
            'projects': projects
        })

# Format and output results
format_results(matches, field_name, project_id)
```

## Error Handling

**File not found:**
- Check Downloads folder for exports
- Ask user for file path
- Provide instructions on how to export from Jira

**JSON parse error:**
- File may be corrupted
- Ask user to re-export from Jira

**No field name provided:**
- Show usage instructions
- Ask user to provide field name

## Tips

- The automation export file is large - searching takes 5-10 seconds
- Field names are case-sensitive in Jira but we search case-insensitive
- Smart values may reference fields indirectly (e.g., `{{issue.customfield_12345}}`)
- Always verify results in Jira UI before making changes

## Related

- Use `/check-jira-automation-field` to verify before changing fields
- Export new automation rules monthly to keep analysis current
- Document critical field dependencies for governance

---

**Last updated:** 2026-03-26
