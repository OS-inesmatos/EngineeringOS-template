#!/usr/bin/env python3
import subprocess
import json
from datetime import datetime
import statistics

def get_issue_changelog(issue_key):
    """Get issue changelog from Jira"""
    try:
        result = subprocess.run(
            ['acli', 'jira', 'workitem', 'view', issue_key, '--json'],
            capture_output=True,
            text=True,
            check=True
        )
        return json.loads(result.stdout)
    except Exception as e:
        print(f"Error fetching {issue_key}: {e}")
        return None

def extract_status_transitions(changelog):
    """Extract status transitions with dates"""
    transitions = []

    if not changelog or 'changelog' not in changelog:
        return transitions

    for history in changelog.get('changelog', {}).get('histories', []):
        created = history.get('created')
        for item in history.get('items', []):
            if item.get('field') == 'status':
                transitions.append({
                    'date': created,
                    'from': item.get('fromString'),
                    'to': item.get('toString')
                })

    return sorted(transitions, key=lambda x: x['date'])

def calculate_leadtime(issue_key):
    """Calculate lead time from Solved to Retrospective Completed"""
    changelog = get_issue_changelog(issue_key)
    if not changelog:
        return None

    transitions = extract_status_transitions(changelog)

    solved_date = None
    completed_date = None

    # Find when it moved to Solved and to Retrospective Completed
    for trans in transitions:
        if trans['to'] == 'SOLVED' or trans['to'] == 'Solved':
            solved_date = trans['date']
        if trans['to'] == 'Retrospective Completed':
            completed_date = trans['date']

    if not solved_date or not completed_date:
        return None

    # Parse dates (format: 2025-01-15T10:30:45.123+0000)
    solved_dt = datetime.fromisoformat(solved_date.replace('Z', '+00:00'))
    completed_dt = datetime.fromisoformat(completed_date.replace('Z', '+00:00'))

    # Calculate difference in days
    leadtime_days = (completed_dt - solved_dt).total_seconds() / 86400

    return {
        'issue_key': issue_key,
        'solved_date': solved_date,
        'completed_date': completed_date,
        'leadtime_days': leadtime_days
    }

def main():
    # Read issue keys from file
    with open('/tmp/rdinc_issues.txt', 'r') as f:
        issue_keys = [line.strip() for line in f if line.strip()]

    print(f"Processing {len(issue_keys)} issues...")
    print()

    leadtimes = []

    for i, issue_key in enumerate(issue_keys, 1):
        print(f"[{i}/{len(issue_keys)}] Processing {issue_key}...", end=' ')
        result = calculate_leadtime(issue_key)

        if result:
            leadtimes.append(result)
            print(f"✓ {result['leadtime_days']:.1f} days")
        else:
            print("✗ Could not calculate")

    print()
    print("=" * 80)
    print("RESULTS")
    print("=" * 80)
    print()

    if leadtimes:
        days = [lt['leadtime_days'] for lt in leadtimes]

        print(f"Total issues analyzed: {len(leadtimes)}")
        print(f"Average lead time: {statistics.mean(days):.1f} days")
        print(f"Median lead time: {statistics.median(days):.1f} days")
        print(f"Min lead time: {min(days):.1f} days")
        print(f"Max lead time: {max(days):.1f} days")
        print(f"Std deviation: {statistics.stdev(days) if len(days) > 1 else 0:.1f} days")
        print()

        # Show distribution
        print("Distribution:")
        buckets = [(0, 30), (30, 60), (60, 90), (90, 120), (120, float('inf'))]
        for min_days, max_days in buckets:
            count = sum(1 for d in days if min_days <= d < max_days)
            label = f"{min_days}-{max_days if max_days != float('inf') else '∞'} days"
            print(f"  {label:15s}: {count:3d} issues ({count/len(days)*100:.1f}%)")

        print()
        print("Detailed breakdown (top 10 longest):")
        print()
        for lt in sorted(leadtimes, key=lambda x: x['leadtime_days'], reverse=True)[:10]:
            print(f"  {lt['issue_key']:15s}: {lt['leadtime_days']:6.1f} days")
    else:
        print("No valid lead times calculated")

if __name__ == '__main__':
    main()
