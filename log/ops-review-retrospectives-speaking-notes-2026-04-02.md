# Ops Review - Retrospective Process Update
*Speaking Notes: April 2, 2026*

---

## Opening

Quick update on our retrospective process metrics.

---

## The Good News

**We're making progress on volume.**

Two weeks ago, we had **35 active retrospectives**. Today we're at **27**.

That's a **23% reduction** in two weeks. We're clearing the backlog.

---

## The Concern

**But lead time is moving in the wrong direction.**

We're now at **90 days** to complete a retrospective. That's up from 71 days in early February - a **27% increase**.

So we're doing fewer retrospectives, but each one is taking longer to complete.

---

## What's Driving This

**The bottleneck is commander assignment.**

Right now, we have **17 incidents** sitting in Solved status with no Retrospective Commander assigned.

Two of those are **Sev1** incidents.

We also have 2 incidents that moved to "Retrospective In Progress" status but still have no commander. That shouldn't happen - if we're marking it as in progress, someone needs to be driving it.

---

## What This Means

The 90-day lead time isn't because retrospectives are getting more complex.

It's because incidents are sitting idle for weeks before anyone is assigned to drive the work.

---

## Next Steps

Three actions:

**First** - assign commanders to the oldest 3 incidents this week. These are the ones that have been waiting the longest.

**Second** - establish an SLA for commander assignment. Proposal: 5 days from incident closure. We need to stop the clock from starting so late.

**Third** - consider clustering related incidents into single retrospectives. We have multiple tenant-provisioning failures and GA ring stability incidents. We don't need 5 separate retrospectives for the same root cause.

---

## Bottom Line

Volume is going down. That's good.

Lead time is going up. We need to fix that.

The fix is clear: get commanders assigned faster.

---

*Data sources:*
- *Dashboard snapshot: 2026-04-02*
- *Jira query: 17 incidents without commander*
