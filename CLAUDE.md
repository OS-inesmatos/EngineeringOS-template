# CLAUDE.md — Engineering Leader OS

*This file tells Claude Code how to work with your Obsidian vault and personal productivity system.*

---

## About This System

This is a personal operating system for engineering leaders, based on Rohun Jauhar's CEO Personal OS framework, adapted for engineering leadership.

**Owner:** [YOUR_NAME]
**Role:** [YOUR_ROLE]
**Company:** [YOUR_COMPANY]
Assistant Name: [ASSISTANT_NAME]
Number of teams: [NUMBER_OF_TEAMS]
Number of direct reports: [NUMBER_OF_DIRECT_REPORTS]
Total number of people in teams: [TOTAL_PEOPLE]

| Placeholder                  | Replace With                    |
| ---------------------------- | ------------------------------- |
| `[YOUR_NAME]`                | Your full name                  |
| `[YOUR_ROLE]`                | Your current title              |
| `[YOUR_COMPANY]`             | Your company name               |
| `[ASSISTANT_NAME]`           | What you want to call your AI assistant |
| `[NUMBER_OF_TEAMS]`          | How many teams you lead         |
| `[NUMBER_OF_DIRECT_REPORTS]` | Your direct reports count       |
| `[TOTAL_PEOPLE]`             | Total people across your teams  |
| `[CURRENT_PRIORITIES]`       | Your current focus areas        |

---

## Vault Structure

```
EngineeringOS/
├── README.md                    # How to use this system
├── writing_style.md             # My writing style
├── principles.md                # My leadership principles
├── north_star.md                # Long-term direction
├── memory.md                    # Accumulated patterns and insights (CRITICAL)
├── frameworks/                  # Mental models and frameworks
├── meetings/
│   ├── raw/                     # Dump of meeting notes per day
│   ├── summaries/               # summary of the meeting for  (YYYY-MM-DD.md)
├── log/
│   ├── daily/                   # Current week's daily notes (YYYY-MM-DD.md)
│   ├── weekly/                  # Weekly folders (YYYY-Www/)
│   │   └── YYYY-Www/            #   Weekly review + that week's daily notes
│   ├── monthly/                 # Monthly summaries (YYYY-MM.md)
│   ├── quarterly/               # Quarterly reviews (YYYY-Qn.md)
│   └── annual/                  # Annual reviews (YYYY.md)
├── goals/
│   ├── 90_day.md                # Current quarter priorities
│   ├── 1_year.md                # This year's goals
├── teams/                       # Team health and context
├── people/                      # Person notes (@Name.md format)
├── initiatives/
│   ├── _dashboard.md            # Overview of all initiatives
│   ├── active/                  # Active initiative folders
|       ├── [initiative_name]/   # Each initiative is a folder
│           ├── _initiative.md   # Tracker (status, tasks, work log)
│           ├── plan.md          # Working document
│   └── completed/               # Completed initiatives
├── decisions/                   # Decision log and ADRs
└── uploads/                     # Past reviews, notes to process
```

---

## Key Files to Always Reference

When helping me, always read these files first:

1. **memory.md** — My patterns, strengths, growth edges, and accumulated insights
2. **writing_style.md** — How I write (CRITICAL for any drafting tasks)
3. **goals/90_day.md** — Current quarter priorities
4. **teams/health_tracker.md** — Team health overview
5. **initiatives/_dashboard.md** — What I'm working on
6. **inbox.md** — Quick capture for tasks and ideas

---

## Skills (Slash Commands)

All workflows are available as skills. Use them with `/skill-name`.

### Daily Operations

| Skill | Command | What it does |
|-------|---------|--------------|
| Morning Routine | `/morning` | Start the day — pulls calendar, reviews yesterday, sets priorities, creates daily note |
| Daily Wrap-Up | `/daily-wrap-up` | End the day — reflects on priorities, notes for tomorrow, commits to GitHub |
| Calendar | `/calendar` | View today's or this week's Google Calendar schedule via Playwright |
| Meeting Notes | `/meeting` | Quick-capture meeting notes into `meetings/raw/` with minimal structure |

### Reviews

| Skill | Command | What it does |
|-------|---------|--------------|
| Weekly Checkpoint | `/weekly-checkpoint` | Weekly review against 90-day goals, creates `log/weekly/YYYY-Www/` |
| Monthly Checkpoint | `/monthly-checkpoint` | Monthly review bridging weekly insights and quarterly goals, creates `log/monthly/YYYY-MM.md` |
| Quarterly Checkpoint | `/quarterly-checkpoint` | Quarter review with goal progress, patterns, memory.md updates |

### Writing

| Skill | Command | What it does |
|-------|---------|--------------|
| Draft | `/draft` | Drafts emails, Slack messages, or documents in my voice |
| Review Draft | `/review-draft` | Reviews a draft for voice/tone, flags AI smell, suggests edits |

### Task Management

| Skill | Command | What it does |
|-------|---------|--------------|
| Add Task | `/add-task [description]` | Quick capture to inbox.md |
| Process Inbox | `/process-inbox` | Triages inbox items to their proper locations in the vault |

### Meeting Prep

| Skill | Command | What it does |
|-------|---------|--------------|
| Prep 1:1 | `/prep1o1` | Pulls context, action items, wins for a 1:1 meeting |
| Prep Skip-Level | `/prep-skip-level` | Prepares skip-level 1:1 with person context, manager context, team health signals, and trust-building questions |
| Staff Meeting Prep | `/staff-prep` | Prepares staff/leadership meetings with context, agenda, and decisions needed |

### Decisions & Leverage

| Skill | Command | What it does |
|-------|---------|--------------|
| Log Decision | `/log-decision` | Captures a decision with context, options, rationale, and trade-offs |
| Leverage Audit | `/leverage-audit` | Audits where time goes vs where it should — finds delegation and automation opportunities |

### Integrations

| Skill | Command | What it does |
|-------|---------|--------------|
| Calendar | `/calendar [today\|week]` | Reads Google Calendar via Playwright browser, parses events, detects conflicts, estimates focus time |

---

## File Naming Conventions

| Type              | Format                 | Example        |
| ----------------- | ---------------------- | -------------- |
| Daily notes       | YYYY-MM-DD.md          | 2026-01-11.md  |
| Weekly reviews    | YYYY-Www.md            | 2026-W02.md    |
| Monthly summaries | YYYY-MM.md             | 2026-01.md     |
| Quarterly reviews | YYYY-Qn.md             | 2026-Q1.md     |
| Person notes      | @FirstName LastName.md | @Sarah Chen.md |

---

## Tagging Conventions

| Tag         | Use                |
| ----------- | ------------------ |
| `- [ ]`     | Task / action item |
| `- [x]`     | Completed task     |
| `- [w]`     | Win to remember    |
| `- [!]`     | Feedback delivered |
| `#decision` | Decision made      |
| `#insight`  | Strategic insight  |
| `#pattern`  | Pattern noticed    |

---

## When Helping Me...

**DO:**
- Reference memory.md for my patterns and context
- **Read writing_style.md BEFORE any drafting task or write any text to pages/files** — match my voice exactly
- Be direct and concise — I prefer clarity over softness
- Call out when I'm repeating past mistakes (check memory.md)
- Suggest connections between current situation and past insights
- Use executive-level language, not therapy-speak
- When drafting: shorter is better, avoid AI-sounding phrases

**DON'T:**
- Add productivity theater or unnecessary structure
- Be overly positive — I want honest assessment
- Forget to reference my 90-day goals for context
- Create new files without checking if similar exists
- Use words from my "avoid" list in writing_style.md
- Sound like ChatGPT default output (too polished, too many transitions)
- Add pleasantries or filler phrases I wouldn't use

---

## My Preferences

- **Tone:** Calm, direct, executive-level
- **Format:** Minimal formatting, no excessive headers or bullets
- **Reviews:** I do daily (5min), weekly (15min), monthly (20min), quarterly (60min)
- **Energy:** Track patterns to optimize my schedule

---

## Integration Notes

This system lives in Obsidian and is accessed by Claude Code.

**Obsidian plugins in use:**
- Dataview (for queries)
- Templater (for templates)
- Periodic Notes (for daily/weekly/monthly)
- Tasks (for action tracking)

**When creating Dataview queries:**
```dataview
LIST
FROM "log/daily"
WHERE file.cday >= date(today) - dur(7 days)
SORT file.cday DESC
```

---

*Last updated: {{date}}*
