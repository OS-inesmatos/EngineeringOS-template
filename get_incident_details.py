import subprocess
import json

incidents = [
    'RDINC-67563', 'RDINC-68402', 'RDINC-68929', 'RDINC-68947', 'RDINC-69224',
    'RDINC-72456', 'RDINC-73070', 'RDINC-73538', 'RDINC-73831', 'RDINC-73895',
    'RDINC-74029', 'RDINC-74666', 'RDINC-74718', 'RDINC-75145', 'RDINC-75390',
    'RDINC-76734', 'RDINC-77260', 'RDINC-78158', 'RDINC-78404'
]

ages = [92, 77, 71, 71, 70, 64, 57, 52, 48, 48, 47, 39, 39, 36, 34, 24, 19, 5, 0]

print("Key,Age,Summary,Description_Preview")
print("-" * 120)

for idx, key in enumerate(incidents):
    result = subprocess.run(
        ['acli', 'jira', 'workitem', 'view', key, '--fields', 'summary,description', '--json'],
        capture_output=True,
        text=True,
        timeout=15
    )
    
    if result.returncode == 0:
        data = json.loads(result.stdout)
        fields = data['fields']
        summary = fields.get('summary', 'N/A')
        description = fields.get('description', {})
        
        # Extract plain text from ADF description
        desc_text = ""
        if description and isinstance(description, dict):
            if 'content' in description:
                for content_block in description['content'][:2]:  # First 2 paragraphs
                    if content_block.get('type') == 'paragraph' and 'content' in content_block:
                        for text_node in content_block['content']:
                            if text_node.get('type') == 'text':
                                desc_text += text_node.get('text', '') + " "
        
        # Clean and truncate
        desc_text = desc_text.strip().replace('\n', ' ').replace(',', ';')[:150]
        if len(desc_text) > 147:
            desc_text = desc_text[:147] + "..."
        
        print(f"{key},{ages[idx]},{summary},{desc_text}")
    else:
        print(f"{key},{ages[idx]},ERROR,ERROR")
