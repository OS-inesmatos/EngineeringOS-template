---
skill_name: calendar
title: Calendar View
description: View today's or this week's calendar from Google Calendar via Playwright
---

# Calendar View

View your Google Calendar schedule parsed into a clean markdown table with conflict detection and focus time estimates.

## Usage

```
/calendar          → today's schedule
/calendar today    → today's schedule
/calendar week     → this week's schedule
```

## Instructions

### Step 1: Navigate to Google Calendar

Based on the argument (default: today):
- **today** → navigate Playwright browser to `https://calendar.google.com/calendar/u/0/r/day`
- **week** → navigate Playwright browser to `https://calendar.google.com/calendar/u/0/r/week`

Use `mcp__playwright__browser_navigate` to open the URL.

Wait 3 seconds for the page to fully load using `mcp__playwright__browser_wait_for`.

### Step 2: Take an accessibility snapshot

Use `mcp__playwright__browser_snapshot` — NOT a screenshot.

The snapshot returns the accessibility tree with all calendar events as interactive elements.

### Step 3: Parse events from the snapshot

Events typically appear as button elements with text patterns like:
```
"9:30 AM to 10 AM, Meeting Name, Organizer Name, Accepted, No location, Color: Grape"
"2 PM to 3 PM, Sprint Planning, Team Lead, Tentative, Room 4B, Color: Banana"
```

For each event, extract:
- **Time range** — start and end time
- **Event name** — the meeting title
- **RSVP status** — Accepted, Tentative, Declined, or Not responded
- **Location** — room or "No location"
- **Category** — the color label (Grape, Banana, Sage, etc.)

**SKIP these entries** — do not include in the active events table:
- "Working location" buttons
- Lunch blocks or meals
- Focus time / Do not disturb blocks
- All-day events that are informational (holidays, OOO notices)

**Track separately:**
- Declined events → list in a "Declined" section
- Tentative events → mark with ⚠ in the status column

**Detect conflicts:**
- Compare all active (non-declined) event time ranges
- If any two events overlap, flag them as a conflict

### Step 4: Output as markdown

For each day, output:

```
### [Day of week], [Month] [Day], [Year]

| Time | Event | Status | Category |
|------|-------|--------|----------|
| 09:30–10:00 | Meeting Name | Accepted | Color |
| 10:00–11:00 | Another Meeting | ⚠ Tentative | Color |
...

**Conflicts:** [list overlapping events, or "None"]
**Declined:** [list declined events, or "None"]
```

Use 24h or AM/PM format matching what the snapshot provides. Use en-dash (–) for time ranges.

### Step 5: Add summary

After all days, add:

```
**Summary:**
- Active events: [count] (excluding declined, focus time, lunch)
- Meeting hours: [total hours]
- Estimated focus time: [hours] ([list gaps ≥ 30 min])
```

Focus time = gaps between meetings that are at least 30 minutes, within working hours (9 AM – 6 PM).

## Tips

- If the browser is not authenticated to Google, tell the user to log in manually and retry.
- If the snapshot is empty or shows a login page, say so clearly — don't guess at events.
- For week view, organize events by day with a section header per day.
- Keep output clean and scannable — this feeds into `/morning` and daily planning.
