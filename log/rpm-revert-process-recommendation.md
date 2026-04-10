# RPM Revert Process - Recommendation
*Date: 2026-04-02*
*Context: RPM-6423 fix caused worse issue, needs revert*

## Current Situation

- RPM-6423 was closed as "Fixed" with release note published
- Fix reached GA
- Discovered the fix causes a more severe issue in undetected use case
- Need to revert the fix

## Problem

**The RPM workflow does not have a "reopen" transition.**

Workflow: New → Under Investigation → Investigation Completed → Release Planned → Closed (final status)

Once in "Closed" status, there's no path back.

## Recommended Approach

**Create a new RPM** for the revert/alternative fix.

### Why This Approach

1. **Maintains clean history** - RPM-6423 was legitimately fixed and deployed to GA
2. **No workflow changes needed** - works within existing process
3. **Clear traceability** - two separate problems with clear relationship
4. **Allows proper release notes** - original fix was valid, revert is a separate change

### Steps

1. **Create new RPM** with:
   - Summary: "[Revert] Original fix from RPM-6423 causes [new issue description]"
   - Description: Explain the regression and why revert is needed
   - Link to RPM-6423 using "relates to"

2. **Add comment to RPM-6423:**
   - "This fix was reverted in [NEW-RPM] due to regression found in [use case]. Release note to follow."

3. **New RPM follows normal workflow:**
   - Under Investigation → document the regression
   - Investigation Completed → revert is the fix
   - Release Planned → write release note explaining revert
   - Closed → when revert reaches GA

4. **Release note for new RPM should:**
   - Reference RPM-6423
   - Explain the issue discovered
   - Confirm the revert
   - Provide workaround if any

### Alternative (Not Recommended)

Ask Jira admins to add "Closed → Under Investigation" transition to the workflow.

**Why not recommended:**
- Requires process change and approval
- Sets precedent that RPMs can bounce back and forth
- Complicates traceability (was it fixed twice? when was each fix active?)
- Release notes become confusing

## Example Response

```
Hi!

The RPM workflow doesn't have a reopen transition by design - once closed, it stays closed.

The recommended approach is to create a new RPM for the revert:

1. Create new RPM referencing RPM-6423 in the title/description
2. Link the two RPMs (relates to)
3. Add a comment to RPM-6423 explaining the regression and linking to the new RPM
4. Follow the normal workflow for the new RPM with a release note explaining the revert

This keeps the history clean and allows proper traceability - RPM-6423 was legitimately fixed and deployed, but that fix caused a regression that requires a separate RPM to address.

Let me know if you need help with the wording for the new RPM or release note.
```

---

*Based on: Problem Management documentation*
*Process ref: https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/5036841027*
