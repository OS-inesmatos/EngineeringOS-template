#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Analyze Jira field usage in automation rules.
"""

import json
import sys
import glob
import re
from pathlib import Path

# Fix Windows console encoding for emoji support
if sys.platform == 'win32':
    import codecs
    sys.stdout = codecs.getwriter('utf-8')(sys.stdout.buffer, 'strict')
    sys.stderr = codecs.getwriter('utf-8')(sys.stderr.buffer, 'strict')


def find_automation_file():
    """Find the most recent automation rules export file."""
    # Check project cache first
    project_cache = Path(__file__).parent.parent.parent / 'data' / 'automation-rules.json'
    if project_cache.exists():
        return project_cache

    # Fallback to Downloads folder
    download_path = Path(r'C:\Users\ios\Downloads')
    files = list(download_path.glob('automation-rules-*.json'))

    if not files:
        return None

    # Return most recent file by name (contains timestamp)
    return max(files, key=lambda x: x.name)


def extract_project_ids(rule):
    """Extract project IDs from a rule."""
    projects = set()

    # Check ruleScope.resources
    rule_scope = rule.get('ruleScope', {})
    resources = rule_scope.get('resources', [])
    for res in resources:
        match = re.search(r'project/(\d+)', res)
        if match:
            projects.add(match.group(1))

    # Check trigger.value.eventFilters
    trigger = rule.get('trigger', {})
    trigger_value = trigger.get('value', {})
    event_filters = trigger_value.get('eventFilters', [])
    for ef in event_filters:
        match = re.search(r'project/(\d+)', ef)
        if match:
            projects.add(match.group(1))

    return list(projects)


def analyze_field_usage(rule, field_name):
    """Analyze how a field is used in a rule."""
    usage = {
        'in_trigger': False,
        'in_condition': False,
        'in_action': False,
        'details': []
    }

    # Check trigger
    trigger = rule.get('trigger', {})
    trigger_value = trigger.get('value', {})
    trigger_fields = trigger_value.get('fields', [])

    for field in trigger_fields:
        if field.get('value', '').lower() == field_name.lower():
            usage['in_trigger'] = True
            usage['details'].append(f"Trigger: Field changed event")

    # Check components (conditions and actions)
    components = rule.get('components', [])
    for comp in components:
        comp_type = comp.get('component')

        # Check conditions
        if comp_type == 'CONDITION':
            comp_value = comp.get('value', {})
            if not comp_value:
                continue
            selected_field = comp_value.get('selectedField', {})
            if selected_field.get('value', '').lower() == field_name.lower():
                usage['in_condition'] = True
                comparison = comp_value.get('comparison', 'unknown')
                usage['details'].append(f"Condition: Checks field ({comparison})")

        # Check actions
        elif comp_type == 'ACTION':
            comp_value = comp.get('value', {})
            if not comp_value:
                continue
            operations = comp_value.get('operations', [])

            for op in operations:
                field = op.get('field', {})
                field_value = field.get('value', '')

                if field_value.lower() == field_name.lower():
                    usage['in_action'] = True
                    op_type = op.get('type', 'unknown')
                    usage['details'].append(f"Action: {op_type} operation on field")

    return usage


def format_usage_details(usage):
    """Format usage details for display."""
    if not usage['details']:
        return "   • Used in automation (details not parsed)"

    result = []
    for detail in usage['details']:
        result.append(f"   • {detail}")
    return '\n'.join(result)


def analyze_automations(automation_file, field_name, project_id=None):
    """Search for field usage in automation rules."""
    print(f"🔍 Searching for field: \"{field_name}\"")
    if project_id:
        print(f"📁 In project: {project_id}")
    print()

    # Load JSON
    try:
        with open(automation_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        print(f"❌ Error loading automation file: {e}")
        return 1

    # Search for field
    rules_data = data.get('rules', [])
    matches = []

    for rule in rules_data:
        rule_str = json.dumps(rule, ensure_ascii=False).lower()

        # Check if field name appears in the rule
        if field_name.lower() not in rule_str:
            continue

        # Extract project IDs
        projects = extract_project_ids(rule)

        # Filter by project if specified
        if project_id and project_id not in projects:
            continue

        # Analyze field usage
        usage = analyze_field_usage(rule, field_name)

        matches.append({
            'rule': rule,
            'projects': projects,
            'usage': usage
        })

    # Display results
    if not matches:
        print(f"✓ No automations found using field \"{field_name}\"")
        print("  Safe to modify or remove this field.")
        return 0

    # Display matches
    print(f"✅ Found {len(matches)} automation(s) using this field:\n")

    for match in matches:
        rule = match['rule']
        projects = match['projects']
        usage = match['usage']

        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

        # Rule name and ID
        rule_name = rule.get('name', 'Unknown')
        rule_id = rule.get('id', 'Unknown')
        state = rule.get('state', 'UNKNOWN')

        state_icon = "⚡" if state == "ENABLED" else "💤"

        print(f"📋 Automation: \"{rule_name}\"")
        print(f"   ID: {rule_id}")
        print(f"   State: {state} {state_icon}\n")

        # Projects
        if projects:
            print("   Projects:")
            for proj in projects:
                print(f"   • Project ID: {proj}")
            print()

        # Trigger
        trigger = rule.get('trigger', {})
        trigger_type = trigger.get('type', 'unknown')
        print(f"   Trigger:")
        print(f"   • Type: {trigger_type}")

        if usage['in_trigger']:
            print(f"   • When: \"{field_name}\" is updated")
        print()

        # How the field is used
        print("   Field Usage:")
        print(format_usage_details(usage))
        print()

    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

    # Impact analysis
    enabled_count = sum(1 for m in matches if m['rule'].get('state') == 'ENABLED')

    print("⚠️  Impact Analysis:\n")
    print(f"This field is used in {len(matches)} automation(s):")
    print(f"• {enabled_count} enabled automation(s) will be affected")

    if project_id:
        project_count = sum(1 for m in matches if project_id in m['projects'])
        print(f"• {project_count} automation(s) in project {project_id}")

    print("\nRecommendations:")
    print("• Review each automation before changing the field")
    print("• Test in non-production environment first")
    print("• Consider disabling automations temporarily during migration")
    print("• Update automation logic if field name/behavior changes")

    return 0


def main():
    """Main entry point."""
    if len(sys.argv) < 2:
        print("Usage: python analyze_field.py \"Field Name\" [project_id]")
        print()
        print("Examples:")
        print('  python analyze_field.py "Error Code"')
        print('  python analyze_field.py "Root Cause Categorization" 24263')
        return 1

    field_name = sys.argv[1]
    project_id = sys.argv[2] if len(sys.argv) > 2 else None

    # Find automation file
    automation_file = find_automation_file()

    if not automation_file:
        print("❌ Error: No automation rules file found in Downloads folder")
        print()
        print("To export automation rules:")
        print("1. Go to Jira Settings → System → Automation")
        print("2. Click Export (requires admin permissions)")
        print("3. Save as JSON to Downloads folder")
        return 1

    print(f"📄 Using automation file: {automation_file.name}\n")

    # Analyze
    return analyze_automations(automation_file, field_name, project_id)


if __name__ == '__main__':
    sys.exit(main())
