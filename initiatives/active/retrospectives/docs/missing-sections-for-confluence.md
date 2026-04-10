# Missing Sections for Confluence Document

**Document:** Retrospective Transformation [Solution Proposed]
**Date:** 2026-04-06
**Purpose:** Complete operational details for execution

---

## 1. INSERT IN "Process Flow" — Expand Step 1

**Location:** After current Step 1 content (line ~81-89)

### Enhanced Step 1: Incident Resolution & Assignment

**Assignment:**
- Faulty asset identified during troubleshooting by Incident Commander
- Engineering Manager or Team Leader of team owning the faulty asset assigned as Retrospective Commander
- EM/TL is accountable for retrospective completion (can delegate execution to team members)
- Idea: Create a Jira field that represents the team that owns the faulty asset and, in consequence, the retrospective

**Document Creation:**
- EM/TL drafts initial retrospective document (or delegates to team member)
- **Timeline:** Within 3 days of incident resolution (see Process SLAs below)
- **Template:** Use standard retrospective template (published in Confluence)
- **Minimum content for skill assessment:**
  - Incident timeline
  - Initial impact assessment
  - Initial root cause hypothesis
  - Detection method

**Output:** Draft retrospective document ready for skill assessment

---

## 2. INSERT NEW SECTION — After "Process Flow"

### Process SLAs / OLAs

Process Engineering monitors the following control points to ensure retrospectives complete within target lead time (<45 days):

| **Control Point** | **SLA/OLA** | **Measurement** | **Owner** |
|-------------------|-------------|-----------------|-----------|
| **Time to Draft** | < 3 days | Incident resolution → draft created in Confluence | EM/TL |
| **Time to Skill Assessment** | < 1 day | Draft created → skill run completed | EM/TL |
| **Time to RCA Session** | < 7 days | Draft created → RCA working session held | Process Eng + EM/TL |
| **Time to Document Update** | < 2 days | Session completed → document updated with session outcomes | EM/TL |
| **Time to VSL Approval** | < 5 days | Document finalized → VSL approval | VSL |
| **Total Lead Time** | < 45 days | Incident resolution → retrospective closed | End-to-end |

**Monitoring:**
- Process Engineering tracks all control points via PowerBI dashboard
- Weekly report to leadership showing retrospectives by status and age
- Alerts when SLAs at risk (e.g., draft not created after 2 days)

**Accountability:**
- EM/TL accountable for draft, assessment, update (Steps 1-4)
- Process Eng accountable for facilitating session on time (Step 3)
- VSL accountable for timely approval (Step 6)

---

## 3. INSERT IN "Progressive Autonomy Model" — Add Tier Management

**Location:** After tier movement explanation (line ~285-291)

### Tier Tracking & Communication

**Tracking Mechanism:**
- Process Engineering maintains team tier status in **Retrospective Quality Dashboard** (PowerBI)
- Updated after each retrospective completion based on quality score
- Visible to:
  - Teams (can see their own tier and score history)
  - Engineering Managers (can see their team's tier)
  - Value Stream Leaders (can see all teams in their VS)

**Tier Assignment:**
- **Initial tier (rollout):** All teams start at Tier 1 (Learning)
- **Tier movement:** Based on 3 consecutive retrospectives meeting tier threshold
- **Score calculation:** Average of last 3 retrospectives

**Communication:**
- **Tier upgrade:** Process Eng sends congratulations message to team + EM/TL
  - "Congratulations! Your team has graduated to Tier 2 (Developing) based on consistent quality scores >40%. Next RCA session will be co-facilitated."
- **At-risk notification:** Process Eng notifies team if score drops below tier threshold
  - "Your team's retrospective quality score dropped to 55% (below Tier 2 threshold of 70%). Process Eng will provide additional support in next session."
- **Tier downgrade:** Process Eng meets with EM/TL to discuss support needs
  - Root cause of quality drop
  - Additional training or resources needed
  - Facilitation model adjusted accordingly

**Quarterly Review:**
- Process Eng presents tier distribution to Value Stream Leaders
- Identifies teams needing additional support
- Celebrates teams reaching Tier 3 (Autonomous)

---

## 4. INSERT IN "Implementation" — Pilot Phase Detail

**Location:** Under "## Timeline and Rollout" (currently empty, line 296)

### Pilot Phase (June 2026)

**Objective:** Validate new model with mature teams before full rollout

**Scope:**
- **Duration:** 4-6 weeks (June 1-30, 2026)
- **Incidents:** 5-10 system-wide incidents
- **Teams:** Mature teams with dedicated SRE support
  - Identity team (confirmed)
  - [2-3 additional teams TBD based on: SRE availability, recent incident activity, team maturity]

**Pilot Success Criteria:**

| **Metric** | **Target** | **Measurement** |
|------------|------------|-----------------|
| Retrospective lead time | < 45 days | 80% of pilot retrospectives |
| Quality score | > 70% | Average across all pilot retrospectives |
| Skill accuracy | > 85% | Process Eng validates skill assessment vs manual review |
| Team feedback | Positive | Survey: teams report process is better than old model |
| Process Eng capacity | Sustainable | Facilitation load is manageable for rollout |

**Pilot Activities:**
1. **Week 1-2 (June 1-14):**
   - Pilot kickoff with selected teams
   - Process Eng facilitates all RCA sessions (Tier 1 model)
   - Skill runs for all pilot retrospectives

2. **Week 3-4 (June 15-28):**
   - Continue facilitation
   - Gather feedback from teams after each session
   - Iterate on skill prompts based on accuracy validation

3. **Week 5 (June 29-30):**
   - Pilot review meeting with pilot teams + VSLs
   - Analyze metrics vs success criteria
   - Document learnings and adjustments needed

**Go/No-Go Decision (June 30):**
- **GO:** Pilot meets success criteria → proceed with full rollout July 1
- **NO-GO:** Significant issues identified → extend pilot or adjust model
  - Examples of NO-GO triggers: Lead time >60d, quality score <50%, negative team feedback

**Pilot Learnings Captured:**
- What worked well (amplify in rollout)
- What needs adjustment (fix before rollout)
- Skill prompt improvements
- Facilitation best practices
- Common team challenges

---

## 5. INSERT IN "Implementation" — Koda Skill Development

**Location:** After "Pilot Phase" section

### Koda Skill Development Plan

**Ownership:** Inês Matos (lead), Vera Branco (support), Process Engineering team

**Technical Approach:**
- **Technology:** LLM-based evaluation (Claude Sonnet or GPT-4)
- **Integration:** Confluence API (read retrospective documents)
- **Input:** Confluence page URL or page content
- **Output:** Markdown assessment report (score, breakdown, guiding questions)
- **Deployment:** Koda skill accessible via `/assess-retrospective <confluence-url>`

**Development Timeline:**

| **Phase** | **Timeline** | **Activities** | **Deliverable** |
|-----------|--------------|----------------|-----------------|
| **Design** | April 1-15 | Define skill inputs/outputs, prompt engineering, test with example retrospectives | Skill specification document |
| **Prototype** | April 16-30 | Build basic skill, test with 3-5 historical retrospectives | Working prototype |
| **Build & Test** | May 1-31 | Refine prompts, add guiding questions, validate accuracy against manual review | Production-ready skill |
| **Pilot** | June 1-30 | Deploy to pilot teams, gather feedback, iterate | Validated skill ready for rollout |
| **Rollout** | July 1+ | Available to all teams | Skill operational |

**Quality Assurance:**
- **Validation method:** Process Eng manually reviews 10-15 retrospectives using framework, compares to skill output
- **Accuracy target:** 85% agreement between skill assessment and manual review
- **Iteration:** Adjust prompts if accuracy <85%

**Fallback Plan:**
If skill not ready or doesn't work well:
- **Short-term:** Process Eng uses manual framework checklist to assess documents
- **Working sessions still happen** — skill is enhancement, not blocker
- **Core process works without skill** — teams can self-assess using framework questions
- **Timeline impact:** Delays automation but doesn't block rollout

**Long-term Improvements (post-rollout):**
- Add trend analysis (team quality score over time)
- Integration with Jira (auto-trigger on incident resolution)
- Automated session scheduling based on skill output

---

## 6. INSERT IN "Implementation" — Enablement Timeline

**Location:** Expand current "Enablement and Support" section (line ~298-314)

### Enablement Timeline

**April 2026: Awareness & Buy-In**

**Week 1 (April 1-7):**
- Finalize presentation materials
- Socialize proposal with key stakeholders (João brings to Product Leadership)

**Week 2 (April 8-14):**
- **April 13:** Present to Value Stream Leaders + Engineering Managers
  - New model overview
  - Expected impact
  - Timeline and rollout plan
  - Q&A and feedback
- Address concerns and questions
- Confirm pilot teams

**Week 3-4 (April 15-30):**
- **Brown Bag #1: New Retrospective Model Overview** (all teams invited)
  - What's changing and why
  - Process flow walkthrough
  - Progressive autonomy model
  - Q&A
  - Recording published for async viewing

- **Brown Bag #2: RCA Framework Deep-Dive** (pilot teams + interested teams)
  - 3 pillars explained with examples
  - Good retrospective vs weak retrospective
  - Common pitfalls (AI theater, surface-level root cause)
  - How to use the framework checklist

**May 2026: Training & Preparation**

**Week 1-2 (May 1-14):**
- Publish **Retrospective Template** in Confluence
  - Structured sections aligned with 3 pillars
  - Example content for each section
  - Tips for writing quality retrospectives

- Publish **RCA Framework Guidance Document**
  - 3 pillars with detailed questions
  - Examples of good/weak answers
  - Links to reference retrospectives (Identity team)

**Week 3 (May 15-21):**
- **Hands-On RCA Workshop** (pilot teams only)
  - 2-hour interactive session
  - Process Eng facilitates mock RCA working session using historical incident
  - Practice using framework to assess retrospective quality
  - Build confidence for pilot

**Week 4 (May 22-31):**
- Pilot teams prepare for June
- Skill testing with historical retrospectives
- Final adjustments to templates and guidance

**June 2026: Pilot (see Pilot Phase section above)**

**July 2026: Full Rollout Enablement**

**Week 1 (July 1-7):**
- **Brown Bag #3: Pilot Learnings & Rollout Kickoff** (all teams)
  - Pilot results and success stories
  - Lessons learned and adjustments made
  - Skill demo (how to use it)
  - What to expect in first retrospective
  - Q&A

**Week 2+ (July 8+):**
- **Office Hours** (weekly, recurring)
  - Process Eng available for questions
  - Teams can bring draft retrospectives for informal review
  - Troubleshooting skill issues

- **On-Demand Support**
  - Slack channel for questions (#retrospective-new-model)
  - Process Eng responds within 24 hours

**Ongoing (August+):**
- Monthly **Retrospective Quality Community of Practice**
  - Share best practices
  - Showcase high-quality retrospectives
  - Continuous improvement discussions

- Quarterly **Framework Review**
  - Are framework questions still relevant?
  - Any updates needed based on learnings?
  - New patterns or anti-patterns identified?

---

## 7. INSERT NEW SECTION — After "Implementation"

### Transition Plan

**Objective:** Smoothly transition from old model (SRE-led, reviewer-based) to new model (EM/TL-led, skill-based)

**In-Flight Retrospectives (Before June 1, 2026):**
- All retrospectives already in progress continue with **old model**
  - SRE remains Retrospective Commander
  - Reviewer assigned from volunteer pool
  - Mandatory readouts still required

- **Target:** Close all in-flight retrospectives by **May 31, 2026**
  - Process Eng works with SRE to prioritize completion
  - VSLs expedite approvals for in-flight retrospectives
  - Focus on retrospectives >60 days old first

**Cutover Date: June 1, 2026 (Pilot Start)**
- All **new system-wide incidents** (from June 1 onward) follow **new model**
- No hybrid period — clean cutover
- Exception: incidents resolved May 31 but assigned June 1 → new model

**Communication:**
- **May 15:** Email to all Engineering Managers
  - "Starting June 1, all new retrospectives follow new model"
  - "Please complete in-flight retrospectives by May 31"
  - Link to new model documentation

- **May 29:** Reminder email + Slack announcement
  - "New model starts Monday June 1"
  - Recap key changes
  - Link to Brown Bag recordings

**Exception Handling:**

| **Scenario** | **Model to Use** |
|--------------|------------------|
| Incident resolved May 20, retrospective started May 25 (old model) | Continue old model until complete |
| Incident resolved May 31, retrospective starts June 2 | New model (EM/TL assigned as commander) |
| Critical incident (SEV1, MTTR >12h) in pilot phase | New model, but Process Eng fully facilitates regardless of team tier |
| Multi-team incident where ownership unclear | EM/TLs collaborate to assign commander; escalate to VSL if needed within 24h |

**SRE Role Transition:**
- **Before June 1:** SRE leads retrospectives as Retrospective Commander
- **After June 1:** SRE transitions to advisory/consultancy role
  - Available for RCA working sessions as subject matter expert
  - Provides technical guidance when requested
  - Focus on strategic work: patterns, tooling, runbook improvements

**Support During Transition:**
- Process Eng available for questions during first 2 weeks (June 1-14)
- Daily check-in with pilot teams in Week 1
- Rapid response to issues or confusion

---

## 8. INSERT NEW SECTION — After "Success Metrics" or in "Implementation"

### Governance & Escalation

**Objective:** Ensure retrospectives are completed within SLAs with appropriate escalation when needed

**Monitoring:**
- **Process Engineering tracks all system-wide incidents** requiring retrospectives
- **PowerBI Dashboard** shows status for each retrospective:
  - 🔴 Draft overdue (>3 days, no draft)
  - 🟡 Session overdue (>7 days, no session scheduled)
  - 🟢 On track (meeting SLAs)
  - ✅ Completed (VSL approved)

**Weekly Reporting:**
- Process Eng sends weekly status report to Value Stream Leaders
  - Retrospectives in progress by status
  - Retrospectives at risk of missing lead time target
  - Retrospectives completed this week (with quality score)

**Escalation Path for Missing Retrospectives:**

| **Timeline** | **Action** | **Owner** |
|--------------|------------|-----------|
| **Day 0** | Incident resolved, EM/TL assigned as Retrospective Commander | Process Eng |
| **Day 2** | Reminder sent to EM/TL if no draft created | Process Eng (automated) |
| **Day 3** | SLA missed: No draft. Process Eng contacts EM/TL directly | Process Eng |
| **Day 5** | Still no draft. Process Eng escalates to Value Stream Leader | Process Eng → VSL |
| **Day 7** | Still no draft. VSL follows up with EM/TL | VSL |
| **Day 10** | Still no draft. Escalate to Director/VP level | VSL → Director |

**Escalation Path for VSL Approval Delays:**

| **Timeline** | **Action** | **Owner** |
|--------------|------------|-----------|
| **Day 0** | Retrospective finalized, sent to VSL for approval | EM/TL |
| **Day 3** | Reminder sent to VSL if no response | Process Eng (automated) |
| **Day 5** | SLA missed: No approval. Process Eng follows up with VSL | Process Eng |
| **Day 10** | Still no approval. Escalate to next leadership level | Process Eng → Director |

**Accountability:**
- **EM/TL:** Accountable for completing retrospective within timelines
- **VSL:** Accountable for timely approval
- **Process Eng:** Accountable for monitoring, reminders, escalation

**Exception Requests:**
- EM/TL can request extension if:
  - Critical incident investigation still ongoing
  - Key participants unavailable (vacation, offsite)
  - Technical complexity requires more time
- **Request process:** Email Process Eng with justification
- **Approval:** VSL approves extension (typically +7 days)

**Quality Gates:**
- Retrospectives scoring <50% cannot be approved until quality improves
  - Process Eng works with team to address gaps
  - Additional RCA session if needed
  - Re-run skill after updates
- VSL can reject retrospective if quality insufficient
  - Team must address feedback and resubmit

---

## 9. INSERT IN "Concerns and Risks" — Add Risk

**Location:** Add to risks table (line ~402+)

| **Risk** | **Mitigation** |
|----------|----------------|
| **Koda skill not ready or doesn't work accurately** | **Fallback plan:** Process Eng uses manual framework checklist to assess documents before working sessions. Skill is enhancement, not blocker — core process (working sessions, progressive autonomy, framework-based quality) works without automation. Teams can self-assess using framework questions. If skill fails during rollout, revert to manual assessment while fixing skill in background. |

---

## 10. INSERT IN "Implementation" — Complete Timeline & Rollout

**Location:** Replace empty "## Timeline and Rollout" section (line 296)

### Timeline and Rollout

**April 2026: Awareness & Preparation**

**April 1-12:**
- Finalize proposal and presentation materials
- Socialize with key stakeholders (Product Leadership)
- Confirm pilot team selection

**April 13:**
- 🎯 **PRESENTATION TO VALUE STREAM LEADERS + ENGINEERING MANAGERS**
  - New model overview
  - Expected impact and rationale
  - Timeline and rollout plan
  - Q&A and feedback

**April 14-30:**
- Address feedback and concerns from presentation
- Brown Bag #1: New Model Overview (all teams)
- Brown Bag #2: RCA Framework Deep-Dive (pilot teams)
- Begin skill development (design & prototype)

---

**May 2026: Training & Preparation**

**May 1-15:**
- Publish retrospective template and RCA framework guidance
- Continue skill development (build & test phase)
- Prepare enablement materials

**May 15-21:**
- Hands-On RCA Workshop with pilot teams
- Validate skill accuracy with historical retrospectives
- Finalize pilot plan and success criteria

**May 22-31:**
- Close all in-flight retrospectives from old model
- Final pilot prep: confirm teams, schedule, communication
- Skill testing complete
- Communication: "New model starts June 1" announcement

---

**June 2026: PILOT PHASE** 🧪

**June 1-14 (Week 1-2):**
- Pilot launches with 3-5 selected teams
- All pilot incidents follow new model (EM/TL as commander)
- Process Eng facilitates all RCA working sessions (Tier 1 model)
- Skill runs for all pilot retrospectives
- Daily check-ins with pilot teams

**June 15-28 (Week 3-4):**
- Continue pilot
- Gather feedback after each session
- Validate skill accuracy vs manual review
- Iterate on skill prompts if needed
- Target: 5-10 retrospectives completed

**June 29-30 (Week 5):**
- Pilot review meeting with pilot teams + VSLs
- Analyze metrics vs success criteria:
  - Lead time <45 days? ✅
  - Quality score >70%? ✅
  - Positive feedback? ✅
  - Skill accurate? ✅
- **Go/No-Go Decision for July rollout**
- Document learnings and adjustments
- Brown Bag #3 prep: Pilot learnings

---

**July 2026: FULL ROLLOUT** 🚀

**July 1-7 (Week 1):**
- 🎯 **NEW MODEL GOES LIVE FOR ALL TEAMS**
- All new system-wide incidents follow new model
- Brown Bag #3: Pilot Learnings & Rollout Kickoff
- Skill available to all teams
- Office hours start (weekly, recurring)

**July 8-31 (Week 2-4):**
- Process Eng facilitates all Tier 1 teams
- Monitor metrics closely: lead time, quality scores, team tier distribution
- Rapid response to issues or questions
- Weekly status reports to VSLs

**July 31:**
- First month review:
  - How many retrospectives completed?
  - Average lead time vs target?
  - Average quality score?
  - Team feedback?
- Adjust as needed

---

**August 2026+: ITERATE & OPTIMIZE** 🔄

**August:**
- Continue monitoring metrics
- Teams begin graduating to Tier 2 (first teams hitting 3 consecutive >40% scores)
- First quarterly tier status review with VSLs
- Identify teams needing additional support

**September:**
- Retrospective Quality Community of Practice launches (monthly)
- Celebrate first teams reaching Tier 3 (Autonomous)
- Refine skill based on 2 months of data

**October (Q4 Start):**
- Quarterly review of new model:
  - Metrics vs success criteria
  - What's working? What needs adjustment?
  - Framework updates needed?
- Plan for Q4 improvements

**December (End of Pilot Period):**
- 6-month success criteria assessment:
  - Lead time <45 days? ✅
  - Assignment latency <3 days? ✅
  - 90% incidents complete? ✅
  - 0 unassigned commanders? ✅
  - Skill operational? ✅
- Present results to leadership
- Plan for 2027 enhancements

---

**2027: CONTINUOUS IMPROVEMENT**

**Q1 2027:**
- Target: 50% teams at Tier 3 (Autonomous)
- Service Reviews integration begins
- DORA metrics correlation

**Q2 2027:**
- Evaluate expanding model to other areas (not just system-wide incidents)
- Consider lowering incident severity threshold (include non-system-wide SEV2?)

---

## Summary of Timeline

| **Phase** | **Timeline** | **Key Milestone** |
|-----------|--------------|-------------------|
| Awareness & Prep | April 2026 | April 13: Present to leadership |
| Training & Prep | May 2026 | Skill ready, pilot teams trained |
| Pilot | June 2026 | 5-10 retrospectives with mature teams |
| Full Rollout | July 2026 | All teams follow new model |
| Iterate & Optimize | August 2026+ | Monitor, adjust, celebrate progress |
| Success Assessment | December 2026 | 6-month success criteria review |

---

**Document Owner:** Inês Matos, Vera Branco
**Last Updated:** 2026-04-06
**Status:** Ready to add to Confluence
