---
skill_name: calendar
title: Calendar View
description: View today's or this week's calendar from Google Calendar via MCP
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

### Step 1: Get calendars

Call `mcp__claude_ai_Google_Calendar__list_calendars` to retrieve the list of available calendars and their IDs.

### Step 2: Fetch events

Based on the argument (default: today), call `mcp__claude_ai_Google_Calendar__list_events` with the appropriate date range:

- **today** → `time_min` = start of today (00:00), `time_max` = end of today (23:59), in ISO 8601 format with timezone
- **week** → `time_min` = start of current Monday, `time_max` = end of current Sunday

Fetch events from the primary calendar (or all calendars if needed).

### Step 3: Parse events from the response

For each event, extract:
- **Time range** — start and end time (from `start.dateTime` / `end.dateTime`)
- **Event name** — `summary`
- **RSVP status** — from `attendees[].responseStatus` for the user's own entry: `accepted`, `tentative`, `declined`, `needsAction`
- **Location** — `location` field, or "No location"

**SKIP these entries** — do not include in the active events table:
- All-day events (those with `start.date` instead of `start.dateTime`)
- Events with `status: cancelled`
- Focus time / Do not disturb blocks (typically titled "Focus time" or "Do not disturb")
- Lunch blocks or meal events

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

| Time | Event | Status | Location |
|------|-------|--------|----------|
| 09:30–10:00 | Meeting Name | Accepted | No location |
| 10:00–11:00 | Another Meeting | ⚠ Tentative | Room 4B |
...

**Conflicts:** [list overlapping events, or "None"]
**Declined:** [list declined events, or "None"]
```

Use HH:MM 24h format. Use en-dash (–) for time ranges.

### Step 5: Add summary

After all days, add:

```
**Summary:**
- Active events: [count] (excluding declined, focus time, all-day)
- Meeting hours: [total hours]
- Estimated focus time: [hours] ([list gaps ≥ 30 min within 09:00–18:00])
```

Focus time = gaps between meetings of at least 30 minutes, within working hours (09:00–18:00).

## Tips

- If the MCP returns an authentication error, tell the user to re-authenticate via the Google Calendar MCP and retry.
- For week view, organize events by day with a section header per day.
- Keep output clean and scannable — this feeds into `/morning` and daily planning.
