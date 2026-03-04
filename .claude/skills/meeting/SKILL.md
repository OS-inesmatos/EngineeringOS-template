---
skill_name: meeting
title: Meeting Notes
description: Quick-capture meeting notes into meetings/YYYY-MM/ with minimal structure
---

# Meeting Notes

Quick-capture a meeting note so you don't lose context. Creates a timestamped file in `meetings/YYYY-MM/` with just enough structure to be useful later.

## Usage

```
/meeting 1:1 with Carlos
/meeting Staff meeting
/meeting Marina — AI initiative alignment
```

## Instructions

The argument after `/meeting` is the meeting description.

1. Parse the description to extract:
   - **Who** — person name(s) or group (e.g., "Carlos", "Staff", "Marina")
   - **Topic** — if provided after a dash or colon (e.g., "AI initiative alignment")

2. Create a file in `meetings/YYYY-MM/` with this naming format:
   `YYYY-MM-DD-<slug>.md` where `<slug>` is a short kebab-case version of the description (e.g., `2026-02-25-1o1-carlos.md`, `2026-02-25-staff-meeting.md`)

3. Use this minimal template:

```markdown
# <Meeting description>
*YYYY-MM-DD*

## Attendees
- <person or group>

## Notes


## Action Items

```

4. After creating, confirm the file path and tell me it's ready for notes.

5. That's it. Don't ask follow-up questions, don't pre-fill content, don't look up person files. This is a blank page with context — I'll fill it in during or after the meeting.

If no argument is provided, ask what the meeting is about.

## Tips

- Speed matters more than structure here — the goal is to reduce friction to zero
- Don't try to pull in context from people files or initiatives — that's what `/prep1o1` is for
- Raw notes don't need to be clean. Typos, fragments, half-thoughts are all fine.
- These notes can be processed later into summaries or folded into daily notes during `/daily-wrap-up`
- If I run this during a meeting, keep the response minimal — just the file path confirmation
