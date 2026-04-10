# EngineeringOS — Engineering Leader Operating System

A personal operating system for engineering leaders, built on Obsidian and powered by Claude Code.

Based on [Rohun Jauhar's CEO Personal OS](https://x.com/rohunjauhar/status/1913267221088497840) framework, adapted for engineering leadership: managing teams, running initiatives, making decisions and developing your leadership over time.

---

## What This Is

EngineeringOS is a vault of markdown files that work together as your daily operating system. Claude Code acts as your AI chief of staff — it reads your context (goals, meetings, patterns, writing style) and helps you run your day, prepare for meetings, draft communications, and reflect on your progress.

**16 built-in skills** (slash commands) automate your workflows:
- `/morning` — start your day with calendar and priorities
- `/calendar` — view today's or this week's schedule from Google Calendar
- `/daily-wrap-up` — reflect and commit to GitHub
- `/meeting` — quick-capture meeting notes
- `/weekly-checkpoint` — weekly review against goals
- `/draft` — write emails and messages in your voice
- `/prep1o1` — prepare for 1:1 meetings with full context
- And 9 more (see CLAUDE.md for the full list)

---

## Prerequisites

Before you start, install the following:

### 1. Obsidian (free)
Download from [obsidian.md](https://obsidian.md). This is where you'll view and edit your vault.

### 2. Node.js 18+
Download from [nodejs.org](https://nodejs.org). Required for Claude Code.

### 3. Claude Code (CLI)
```bash
npm install -g @anthropic-ai/claude-code
```
You'll need an Anthropic API key or a Claude subscription. See [Claude Code docs](https://docs.anthropic.com/en/docs/claude-code) for setup.

### 4. Git
Download from [git-scm.com](https://git-scm.com). Used for version control and daily backups (the `/daily-wrap-up` skill commits and pushes automatically).

---

## Setup (15 minutes)

### Step 1: Clone this repo

```bash
git clone <your-repo-url> EngineeringOS
cd EngineeringOS
```

### Step 2: Open as an Obsidian vault

1. Open Obsidian
2. Click "Open folder as vault"
3. Select the `EngineeringOS` folder

### Step 3: Install Obsidian plugins

Go to Settings > Community Plugins > Browse, and install:
- **Dataview** — for queries across your vault
- **Tasks** — for action item tracking (`- [ ]`, `- [x]`, etc.)
- **Templater** — for templates
- **Periodic Notes** — for daily/weekly/monthly note creation

### Step 4: Personalize your core files

Open each file and replace the placeholders:

**CLAUDE.md** — Replace all `[YOUR_NAME]`, `[YOUR_ROLE]`, `[YOUR_COMPANY]`, etc. This is how Claude understands who you are.

**north_star.md** — Your long-term direction. Where are you headed in 1, 3, 10 years?

**memory.md** — Your strengths, growth edges, decision patterns. Start with what you know about yourself. This file grows over time as Claude learns your patterns.

**writing_style.md** — How you write. Fill in the tone profile, your actual phrases, words to avoid. The more specific you are, the better Claude drafts for you.

**principles.md** — Your leadership principles. What do you believe about leadership, teams, engineering, communication?

**goals/90_day.md** — Your current quarter priorities. What are the top 3 things you're focused on?

**goals/1_year.md** — This year's goals. What does success look like in 12 months?

### Step 5: Start using it

```bash
cd EngineeringOS
claude
```

Then try your first skill:

```
/morning
```

---

## Daily Workflow

**Morning (~5 min):**
```
/morning
```
Pulls today's calendar from Google Calendar, reviews yesterday, sets priorities, creates a daily note.

**During the day:**
```
/add-task Follow up with Carlos on dependency plan
/meeting 1:1 with Sarah
/draft
```
Capture tasks, meeting notes, and draft communications as you go.

**Evening (~5 min):**
```
/daily-wrap-up
```
Reflects on the day, commits everything to GitHub.

---

## Review Cadence

| Review | Command | Frequency | Time |
|--------|---------|-----------|------|
| Daily | `/morning` + `/daily-wrap-up` | Every day | 5 min each |
| Weekly | `/weekly-checkpoint` | Every Friday | 15 min |
| Monthly | `/monthly-checkpoint` | End of month | 20 min |
| Quarterly | `/quarterly-checkpoint` | End of quarter | 60 min |

---

## All Skills

| Skill | Command | What it does |
|-------|---------|--------------|
| Morning Routine | `/morning` | Start the day with calendar and priorities |
| Calendar | `/calendar` | View today's or this week's Google Calendar |
| Daily Wrap-Up | `/daily-wrap-up` | Reflect and commit to GitHub |
| Meeting Notes | `/meeting` | Quick-capture meeting notes |
| Weekly Checkpoint | `/weekly-checkpoint` | Weekly review against goals |
| Monthly Checkpoint | `/monthly-checkpoint` | Monthly review bridging weekly and quarterly |
| Quarterly Checkpoint | `/quarterly-checkpoint` | Quarter review with pattern updates |
| Draft | `/draft` | Draft emails/Slack/docs in your voice |
| Review Draft | `/review-draft` | Review a draft for voice and AI smell |
| Add Task | `/add-task` | Quick capture to inbox |
| Process Inbox | `/process-inbox` | Triage inbox items to proper locations |
| Prep 1:1 | `/prep1o1` | Prepare for 1:1 meetings |
| Prep Skip-Level | `/prep-skip-level` | Prepare for skip-level 1:1s |
| Staff Meeting Prep | `/staff-prep` | Prepare for staff/leadership meetings |
| Log Decision | `/log-decision` | Capture decisions with rationale |
| Leverage Audit | `/leverage-audit` | Audit time allocation and find leverage |
| Audit Jira Field | `/audit-jira-field` | Check if a Jira field is used in automations |

**Note:** The `/calendar` skill requires the [Playwright MCP server](https://github.com/anthropics/anthropic-quickstarts/tree/main/mcp-servers/playwright) configured in your Claude Code MCP settings. It uses Playwright to open Google Calendar in a browser and read your schedule via accessibility snapshots.

---

## Governance & Tools

### Audit Jira Field Usage

Before changing or removing Jira fields, check if they're used in automations:

```bash
/audit-jira-field "Field Name"
/audit-jira-field "Field Name" --project 24263
```

**How it works:**
- Searches cached Jira automation rules (`.claude/data/automation-rules.json`)
- Shows which automations use the field
- Provides impact analysis and recommendations

**Update automation cache:**
Export from Jira (Settings → System → Automation → Export) and replace `.claude/data/automation-rules.json`.

---

## Optional: Upload Past Context

If you have past performance reviews, 360 feedback, or self-assessments, drop them in `uploads/`. You can reference them when filling in `memory.md` to give Claude a richer picture of your patterns and growth areas.

---

## How It Works

The magic is in the context accumulation:

1. **memory.md** grows over time as you do reviews and Claude surfaces patterns
2. **writing_style.md** teaches Claude your authentic voice
3. **Daily/weekly/monthly reviews** create a rich history that informs every interaction
4. **Person notes** in `people/` give Claude context for meeting prep
5. **Goals** keep every skill aligned with what actually matters

The more you use it, the better it gets. After a few weeks, Claude will know your patterns, catch your blind spots, and draft messages that sound like you.

---

## Customization

This is a template. Make it yours:

- **Add skills** — Create new folders in `.claude/skills/` with a `SKILL.md` file
- **Add frameworks** — Drop mental models in `frameworks/`
- **Modify reviews** — Adjust the review templates in the skill files to match your style
- **Add data sources** — If you have access to engineering metrics, create a custom skill to query them

---

## Credits

- Framework: [Rohun Jauhar's CEO Personal OS](https://x.com/rohunjauhar/status/1913267221088497840)
- Built with: [Obsidian](https://obsidian.md) + [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- Created by: [Adolfo Nunes](https://github.com/adolfonunes)
