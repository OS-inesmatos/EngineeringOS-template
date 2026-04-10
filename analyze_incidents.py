#!/usr/bin/env python3
import subprocess
import json
from datetime import datetime

incidents = ['RDINC-76734', 'RDINC-75145', 'RDINC-74666', 'RDINC-73895', 'RDINC-73831', 'RDINC-73538', 'RDINC-69224', 'RDINC-67563']
today = datetime(2026, 4, 7)

print("Key,Summary,Status,Priority,Created,Age_Days,Value_Stream")

for key in incidents:
    result = subprocess.run(['acli', 'jira', 'workitem', 'view', key, '--fields', 'summary,status,priority,created', '--json'], capture_output=True, text=True)
    if result.returncode == 0:
        data = json.loads(result.stdout)
        fields = data['fields']
        summary = fields.get('summary', '').replace(',', ';')
        status = fields.get('status', {}).get('name', 'N/A')
        priority = fields.get('priority', {}).get('name', 'N/A')
        created_str = fields.get('created', '')
        if created_str:
            created_dt = datetime.fromisoformat(created_str.replace('+0000', '').replace('+0100', ''))
            age_days = (today - created_dt).days
            created_date = created_str[:10]
        else:
            age_days = 'N/A'
            created_date = 'N/A'
        if 'osall' in summary.lower():
            value_stream = 'Cross-platform'
        elif ' ga ' in summary.lower() or summary.lower().startswith('system-wide - ga'):
            value_stream = 'Platform/Infrastructure'
        else:
            value_stream = 'Unknown'
        print(f"{key},{summary},{status},{priority},{created_date},{age_days},{value_stream}")
    else:
        print(f"{key},ERROR,ERROR,ERROR,ERROR,ERROR,ERROR")
