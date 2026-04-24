# Retrospective Quality Dashboard

HTML dashboard for visualizing retrospective assessment results using RCA Framework v2.0.

## Structure

```
dashboard/
├── index.html          # Main dashboard with assessment cards
├── metrics.html        # Aggregate metrics and charts
├── css/
│   └── styles.css      # All styles
├── js/
│   ├── dashboard.js    # Dashboard logic
│   └── metrics.js      # Metrics page logic
└── data/
    └── assessments.json # Assessment data (auto-generated)
```

## How to Use

### 1. Open the Dashboard

Simply open `index.html` in a browser:

```bash
# Option 1: Direct open
start index.html

# Option 2: Local server (recommended for file:// protocol issues)
python -m http.server 8000
# Then visit: http://localhost:8000
```

### 2. Navigate

- **Dashboard (index.html):** View all retrospective assessments as cards
- **Metrics (metrics.html):** View aggregate charts and trends

### 3. Adding New Assessments

The dashboard reads from `data/assessments.json`. When you run a new assessment, the skill should automatically update this file.

**Manual update (if needed):**

```json
{
  "assessments": [
    {
      "id": "RDINC-XXXXX",
      "title": "Incident title",
      "severity": "SEV1",
      "teams": ["Team A", "Team B"],
      "assessmentDate": "2026-04-24",
      "incidentDate": "2026-04-13",
      "assessmentType": "pre",
      "overallScore": 77,
      "status": "ready-for-approval",
      "pillarScores": {
        "detection": 83,
        "response": 38,
        "troubleshooting": 100,
        "recovery": 86,
        "prevention": 75,
        "compliance": 75
      },
      "questionsScored": {
        "total": 26,
        "fullyAddressed": 17,
        "presentButWeak": 5,
        "missing": 4,
        "notApplicable": 0
      },
      "topGaps": [
        {
          "pillar": "Response & Communication",
          "question": "Was external communication effective?",
          "priority": "high",
          "status": "missing"
        }
      ],
      "confluenceUrl": "https://...",
      "assessmentUrl": "https://...",
      "mttr": 2.0,
      "customerImpact": "186 tenants",
      "reviewer": "Koda Pre-Assessment v2.0"
    }
  ]
}
```

## Features

### Dashboard (index.html)

- **Stats Cards:** Total assessments, average score, ready/needs work counts
- **Assessment Cards:** Each retro displayed as a card with:
  - Overall score badge (color-coded)
  - Pillar breakdown with mini progress bars
  - Top 3 gaps
  - Metadata (date, teams, MTTR, severity)
  - Click to view detail (future)

### Metrics (metrics.html)

- **Score Distribution:** Histogram showing quality band distribution
- **Pillar Averages:** Which pillars are weakest across all retros?
- **Score Over Time:** Line chart showing quality trend
- **Common Gaps:** Most frequently missing questions

## Score Ranges

| Score | Badge | Meaning |
|-------|-------|---------|
| 85-100 | 🟢 Excellent | Ready for approval, high quality |
| 70-84 | 🔵 Good | Ready for approval |
| 40-69 | 🟡 Needs Work | RCA working session recommended |
| 0-39 | 🔴 Poor | Significant gaps, requires work |

## Hosting Options

### Option 1: Local (Current)
Open `index.html` directly in browser

### Option 2: GitHub Pages
1. Push to GitHub
2. Enable GitHub Pages on `main` branch
3. Access via `https://username.github.io/repo/dashboard/`

### Option 3: Confluence
Attach HTML files to Confluence page and link directly

### Option 4: Internal Web Server
Deploy to OutSystems internal web server (if available)

## Next Steps

Future enhancements:
- [ ] Detail page per retrospective (retro-detail.html?id=RDINC-XXXXX)
- [ ] Filters (by team, severity, date range)
- [ ] Export to PDF
- [ ] Integration with Jira (fetch data directly)
- [ ] Auto-refresh from Confluence

---

**Owner:** Process Engineering (Ines Matos)
**Framework Version:** RCA Framework v2.0
**Last Updated:** 2026-04-24
