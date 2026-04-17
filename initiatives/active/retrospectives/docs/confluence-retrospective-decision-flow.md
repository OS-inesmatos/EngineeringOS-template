# Retrospective Process — Decision Flow

**For:** Visual reference for decision points and paths  
**Last Updated:** 2026-04-15

---

## Full Process Flow with Decision Points

```
┌─────────────────────────────────────────────────────────────────┐
│                    INCIDENT CLOSED                              │
│                                                                 │
│  • Service restored                                             │
│  • RDINC status: Solved                                         │
│  • Faulty asset identified                                      │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────────┐
│              STEP 1: ASSIGN COMMANDER                           │
│                                                                 │
│  Process Engineering:                                           │
│  • Identifies asset owner (from troubleshooting)                │
│  • Assigns EM/TL of asset-owning team as Commander             │
│  • Notification: Jira + Slack                                   │
│                                                                 │
│  SLA: <3 days                                                   │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
            ┌────────┴────────┐
            │  Commander      │
            │  assigned?      │
            └────────┬────────┘
                     │
            YES ─────┤
                     │
                     ▼
┌─────────────────────────────────────────────────────────────────┐
│              STEP 2: CREATE DRAFT                               │
│                                                                 │
│  Commander (EM/TL or delegate):                                 │
│  • Gathers incident data (RDINC, Slack, Rootly)                │
│  • Creates Confluence doc using template                        │
│  • Includes: timeline, impact, root cause, detection            │
│                                                                 │
│  Options:                                                       │
│  ├─ Manual: Use template, populate from incident data           │
│  └─ Automated (coming soon): Koda skill auto-generates          │
│                                                                 │
│  SLA: <3 days from assignment                                   │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────────┐
│           STEP 3: PRE-ASSESSMENT                                │
│                                                                 │
│  Commander runs assessment:                                     │
│  • Koda skill /assess-retrospective (or manual)                 │
│  • Framework evaluates against 6 pillars                        │
│  • Output: Score (0-100%), gap analysis                         │
│                                                                 │
│  Score breakdown:                                               │
│  ├─ Detection & Monitoring: X/6 questions                       │
│  ├─ Response & Communication: X/4 questions                     │
│  ├─ Troubleshooting & Root Cause: X/3 questions                 │
│  ├─ Recovery & Resolution: X/6 questions                        │
│  ├─ Prevention & Learning: X/5 questions                        │
│  └─ Process Compliance: X/4 questions                           │
│                                                                 │
│  SLA: <1 day from draft                                         │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
            ┌────────┴────────┐
            │  Pre-score      │
            │    >70%?        │
            └────────┬────────┘
                     │
         NO ─────────┼─────────── YES
         │           │            │
         │           │            ▼
         │           │   ┌────────────────────┐
         │           │   │ High score!        │
         │           │   │ Can skip session?  │
         │           │   │ (If all pillars    │
         │           │   │  strong)           │
         │           │   └────────┬───────────┘
         │           │            │
         │           │      ┌─────┴─────┐
         │           │      │           │
         │           │     YES         NO
         │           │      │           │
         │           │      ▼           │
         │           │  ┌───────────┐   │
         │           │  │ Request   │   │
         │           │  │ approval  │   │
         │           │  │ to skip   │   │
         │           │  │ (Process  │   │
         │           │  │  Eng)     │   │
         │           │  └───────────┘   │
         │           │      │           │
         │           │      ▼           │
         │           │  Go to Step 7   │
         │           │      │           │
         ▼           ▼      │           ▼
┌─────────────────────────────────────────────────────────────────┐
│         STEP 4: WORKING SESSION                                 │
│                                                                 │
│  Attendees:                                                     │
│  • Commander (or delegate)                                      │
│  • Process Engineering (facilitator)                            │
│  • Key team members                                             │
│  • Optional: SRE, Quality, other teams                          │
│                                                                 │
│  Agenda (60-90 min):                                            │
│  1. Review pre-assessment (5 min)                               │
│  2. Pillar-by-pillar gap discussion (50-70 min)                 │
│     ├─ Red pillars (<40%): 15-20 min each                       │
│     ├─ Yellow pillars (40-70%): 10 min each                     │
│     └─ Green pillars (>70%): 5 min or skip                      │
│  3. Define action items with owners (10-15 min)                 │
│  4. Next steps (5 min)                                          │
│                                                                 │
│  Facilitation level (Progressive Autonomy):                     │
│  ├─ Tier 1 (0-40%): Process Eng fully facilitates              │
│  ├─ Tier 2 (40-70%): Team co-facilitates, Process Eng observes │
│  └─ Tier 3 (70-100%): Team self-leads, Process Eng consults    │
│                                                                 │
│  SLA: <7 days from draft                                        │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────────┐
│          STEP 5: UPDATE DOCUMENT                                │
│                                                                 │
│  Commander (or delegate):                                       │
│  • Incorporates insights from working session                   │
│  • Addresses all identified gaps                                │
│  • Finalizes action items section                               │
│  • Creates Problem Records (RPMs) for each action item          │
│  • Links RPMs to retrospective                                  │
│                                                                 │
│  SLA: <2 days from session                                      │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────────┐
│         STEP 6: POST-ASSESSMENT                                 │
│                                                                 │
│  Commander re-runs assessment:                                  │
│  • Same process as pre-assessment (Step 3)                      │
│  • Output: New score (e.g., 45% → 85%)                          │
│  • Before/after comparison shows improvement                    │
│                                                                 │
│  Quality check:                                                 │
│  • All gaps addressed?                                          │
│  • Score >70%?                                                  │
│                                                                 │
│  SLA: Same day as document update                               │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
            ┌────────┴────────┐
            │  Post-score     │
            │    >70%?        │
            └────────┬────────┘
                     │
         NO ─────────┼─────────── YES
         │           │            │
         │           │            ▼
         ▼           │   ┌────────────────────┐
  ┌──────────────┐  │   │  Quality threshold │
  │  Gaps remain │  │   │  met — ready for   │
  │  Fix & re-   │  │   │  approval          │
  │  assess      │  │   └────────┬───────────┘
  └──────┬───────┘  │            │
         │          │            │
         └──────────┘            ▼
              │
              ▼
┌─────────────────────────────────────────────────────────────────┐
│         STEP 7: VSL APPROVAL                                    │
│                                                                 │
│  Commander submits to VSL:                                      │
│  • Retrospective document link                                  │
│  • Post-assessment score                                        │
│  • Action items + RPMs                                          │
│                                                                 │
│  VSL reviews:                                                   │
│  • Confirms quality threshold met                               │
│  • Reviews action items                                         │
│  • Approves or requests changes                                 │
│                                                                 │
│  SLA: <5 days from submission                                   │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
            ┌────────┴────────┐
            │  VSL            │
            │  approves?      │
            └────────┬────────┘
                     │
         NO ─────────┼─────────── YES
         │           │            │
         ▼           │            ▼
  ┌──────────────┐  │   ┌────────────────────┐
  │  Changes     │  │   │  RETROSPECTIVE     │
  │  requested   │  │   │  CLOSED            │
  │              │  │   │                    │
  │  Address     │  │   │  • RDINC updated   │
  │  feedback &  │  │   │  • Action items    │
  │  resubmit    │  │   │    tracked via     │
  └──────┬───────┘  │   │    Problem Mgmt    │
         │          │   │  • Team metrics    │
         └──────────┘   │    updated         │
              │         └────────────────────┘
              ▼
       Back to Step 5
       or Step 6
```

---

## Special Cases & Variations

### Case 1: Multi-Team Incident

```
Incident involves multiple teams
         │
         ▼
  EMs/TLs collaborate
         │
    ┌────┴────┐
    │ Agree   │
    │ on lead │
    │ team?   │
    └────┬────┘
         │
    NO ──┼── YES
    │    │    │
    ▼    │    ▼
Escalate │  Lead team EM/TL
to VSLs  │  = Commander
    │    │    │
    └────┴────┘
         │
         ▼
  Standard process
```

---

### Case 2: Recurring Incident Detected

```
Framework check: "Is this recurring?" (Pillar 5, Q2)
         │
         ▼
    ┌────┴────┐
    │Similar  │
    │incident │
    │in last  │
    │90 days? │
    └────┬────┘
         │
    NO ──┼── YES
    │    │    │
    ▼    │    ▼
Standard │  Check previous
process  │  retrospective
         │    │
         │    ▼
         │  ┌─────────────┐
         │  │ Action items│
         │  │ from prev   │
         │  │ retro       │
         │  │ executed?   │
         │  └──────┬──────┘
         │         │
         │    NO ──┼── YES
         │    │    │    │
         │    ▼    │    ▼
         │  🔴 RED │  Continue
         │  FLAG   │  process
         │    │    │    │
         │    ▼    │    ▼
         │ Escalate│ Analyze
         │ to EM & │  why
         │ VSL     │ recurred
         │    │    │    │
         └────┴────┴────┘
              │
              ▼
      Problem Management
      escalation (M3.4)
```

---

### Case 3: SLA at Risk

```
Any step exceeds SLA
         │
         ▼
  Process Eng alerts
         │
    ┌────┴────┐
    │Blocker? │
    └────┬────┘
         │
    YES ─┼─ NO
    │    │   │
    ▼    │   ▼
Identify │ Commander
blocker  │ behind?
    │    │   │
    ▼    │   ▼
┌────────┐  Reminder
│Data    │  sent
│missing?│  │
│Multi-  │  ▼
│team    │ Escalate
│issue?  │ if no
│Resource│ progress
│gap?    │
└───┬────┘
    │
    ▼
Process Eng
supports
resolution
    │
    ▼
Back on track
```

---

### Case 4: Very High Score (Pre-Assessment >85%)

```
Pre-assessment score >85%
         │
         ▼
    ┌────┴────┐
    │All      │
    │pillars  │
    │strong?  │
    └────┬────┘
         │
    NO ──┼── YES
    │    │    │
    ▼    │    ▼
Working  │  Commander requests
session  │  to skip session
needed   │    │
(focus   │    ▼
weak     │  Process Eng reviews
pillars) │    │
    │    │    ▼
    │    │  ┌──────────┐
    │    │  │Approve   │
    │    │  │skip?     │
    │    │  └────┬─────┘
    │    │       │
    │    │  YES ─┼─ NO
    │    │  │    │  │
    │    │  ▼    │  ▼
    │    │ Direct│Working
    │    │ to    │session
    │    │ VSL   │required
    │    │ approval│
    │    │  │    │  │
    └────┴──┴────┴──┘
         │
         ▼
  Continue process
```

---

## Decision Matrix: Working Session Needed?

| Pre-Score | All Pillars >60%? | Working Session |
|-----------|-------------------|-----------------|
| 0-40% | Any | ✅ Required — Major gaps |
| 40-70% | Any | ✅ Required — Significant gaps |
| 70-85% | No (some weak) | ✅ Required — Focus on weak pillars |
| 70-85% | Yes | ⚠️ Optional — Commander decides |
| >85% | Yes | ✅ Can request skip (Process Eng approval) |

---

## Progressive Autonomy Path

```
┌────────────────┐
│  New Team      │
│  (Score 0-40%) │
│  Tier 1        │
└────────┬───────┘
         │
         ▼
  Full facilitation
  by Process Eng
         │
   ┌─────┴──────────┐
   │ Score improving│
   │ to 40-70%      │
   └─────┬──────────┘
         │
         ▼
┌────────────────┐
│ Improving Team │
│ (Score 40-70%) │
│ Tier 2         │
└────────┬───────┘
         │
         ▼
  Co-facilitation:
  Team leads,
  Process Eng observes
         │
   ┌─────┴──────────┐
   │ Score improving│
   │ to 70-100%     │
   └─────┬──────────┘
         │
         ▼
┌────────────────┐
│  Mature Team   │
│ (Score 70-100%)│
│ Tier 3         │
└────────┬───────┘
         │
         ▼
  Self-facilitation:
  Team runs sessions,
  Process Eng consults
  only when requested
         │
         ▼
  ┌──────────────┐
  │ Full autonomy│
  │ achieved     │
  └──────────────┘
```

---

## Escalation Paths

### When to Escalate to Process Engineering

```
Issues:
├─ Can't identify faulty asset
├─ Multi-team ownership dispute
├─ Missing data/information
├─ SLA at risk
└─ Tool/access issues

Action: Contact Process Eng immediately
```

---

### When to Escalate to VSL

```
Issues:
├─ Recurring incident + incomplete action items
├─ Systemic issue detected (M3.4)
├─ Critical incident needing faster review
├─ Multi-team escalation unresolved
└─ Process breakdown

Action: Commander escalates to VSL
```

---

### When to Escalate to Leadership (via VSL)

```
Issues:
├─ Pattern of recurring incidents (same root cause)
├─ Action item execution failure (organizational issue)
├─ Resource constraints blocking retrospectives
└─ Process model not working for specific area

Action: VSL escalates to leadership with data
```

---

## Quality Gates

### Gate 1: Draft Quality (Pre-Assessment)

**Minimum to proceed:**
- [ ] Incident timeline present
- [ ] Customer impact documented
- [ ] Root cause hypothesis documented
- [ ] Detection method documented
- [ ] Score calculated

**If fails:** Gather more data before working session

---

### Gate 2: Working Session Readiness

**Minimum to proceed:**
- [ ] Pre-assessment complete (score calculated)
- [ ] Gap analysis available
- [ ] Key attendees confirmed
- [ ] Session scheduled within SLA

**If fails:** Reschedule, ensure preparation complete

---

### Gate 3: Post-Session Quality

**Minimum to proceed:**
- [ ] All ❌ gaps addressed
- [ ] All ⚠️ weak areas deepened
- [ ] Action items defined with owners
- [ ] RPMs created
- [ ] Post-score >70%

**If fails:** Additional work needed, re-assess

---

### Gate 4: VSL Approval

**Minimum to proceed:**
- [ ] Post-score >70%
- [ ] Document complete and clear
- [ ] Action items specific and tracked
- [ ] Recurrence check completed
- [ ] Customer impact quantified

**If fails:** Address VSL feedback, resubmit

---

## Metrics Flow

```
Each retrospective generates:
         │
         ├─ Lead time (days)
         │   └─ Tracked by Process Eng
         │
         ├─ Quality score (%)
         │   └─ Pre and post-assessment
         │
         ├─ Action items (#)
         │   └─ Tracked via Problem Mgmt
         │
         └─ Pillar scores (% per pillar)
             └─ Identify team strengths/gaps
                     │
                     ▼
              Aggregated monthly
                     │
          ┌──────────┴──────────┐
          │                     │
          ▼                     ▼
    Team metrics          Organization metrics
    │                     │
    ├─ Avg lead time      ├─ Overall lead time trend
    ├─ Avg quality score  ├─ % meeting SLA
    ├─ Action item rate   ├─ Recurrence rate
    └─ Maturity tier      └─ Pillar strengths/gaps
          │                     │
          ▼                     ▼
    Team retrospectives   Ops Review
    (EM reviews)          (Leadership)
```

---

## Summary: Key Decision Points

| Decision Point | Question | Outcome |
|----------------|----------|---------|
| **Step 1** | Commander assigned? | If NO → Process Eng escalates to resolve |
| **Step 3** | Pre-score >70%? | If YES + strong pillars → Can request skip session |
| **Step 4** | Session needed? | Based on score + pillar strength |
| **Step 6** | Post-score >70%? | If NO → Fix gaps, re-assess |
| **Step 7** | VSL approves? | If NO → Address feedback, resubmit |
| **Pillar 5** | Recurring issue? | If YES + action items incomplete → Escalate |

---

**Use this flow for:**
- Understanding process at a glance
- Training new Commanders
- Troubleshooting stuck retrospectives
- Identifying escalation needs

**Full details:** [Operational Guide](link)