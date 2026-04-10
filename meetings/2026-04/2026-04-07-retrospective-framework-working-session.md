# Working Session: Retrospective Framework Pillars & Operating Model
## April 7, 2026 | 11:00–12:00

**Attendees:** Vera Branco, Inês Matos

**Objective:** Define framework pillars, clarify Quality involvement, refine operating model

---

## Key Decisions

### 1. Ownership Model Refined

**Critical clarification:** Retrospective ownership lies with the **faulty asset owner**, not just "team that caused the incident"

**Assignment workflow:**
1. SRE identifies most likely faulty asset during incident response
2. Asset ownership correlated with team structure
3. Retro commander assigned to team lead/engineering manager owning the asset

**OLA target:** Time from incident closure to retro commander assignment (depends on SRE asset identification + ownership correlation)

---

### 2. Framework Validation Status

**Current state:**
- Inês drafted retrospective preparation framework
- Tested against live incident: [RDINC-72566 - NATS Publishing Issue](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6174703908/Assessment+RDINC-72566+-+NATS+Publishing+Issue)
- Framework uses pillar-based assessment to generate preparation score

**Next steps:**
1. **Framework validation (Inês):** Test framework against 3-5 additional live incidents
   - Goal: Identify missing questions on pillars
   - Suggest new questions to introduce based on incident patterns

2. **Framework scoring (Inês):** Once framework reaches solid 1st draft
   - Run framework against same incident samples
   - Generate retrospective preparation scores
   - Validate scoring consistency

3. **Quality alignment (Vera):** Align with Vijay (Quality) on questions to include
   - Testing gaps identification
   - Quality gate failures analysis
   - Bug escape correlation

4. **SRE alignment (Inês):** Share results with Charola (SRE)
   - Validate asset identification workflow during incident response
   - Discuss prep report automation viability

---

### 3. OLA/SLA Philosophy: Outcomes Over Outputs

**Critical shift:** Focus on outcomes the process generates, NOT just document production

**Overall OLA chain:**
1. Incident closure → Retro commander assigned (depends on SRE asset identification)
2. Retro commander assigned → RCA exercise booked
3. RCA exercise booked → Document completed
4. Document completed → Signed off (EM review + VS Leader approval)

**Target:** <14 days end-to-end by Q2 2027 (M3.5 metric)

**Quarterly improvement:** Establish lead time reduction targets per quarter
- Q2 2026: Baseline collection
- Q3 2026 → Q2 2027: Progressive lead time reduction

**Outcome metrics to track:**
- Time to assign retro commander
- Retrospective preparation score (framework-based)
- Incident recurrence rate (same topic/problem)
- Action item closure rate (M3.2: >80% by Q2 2027)
- Maturity score per value stream (M3.6: >4.0/5.0 by Q2 2027)

---

### 4. Recurrence Measurement Requirement

**Framework must account for:**
- Measurement of incident recurrence
- Check previous incidents related to same topic/problem
- Identify patterns that indicate systemic issues not resolved

**Purpose:**
- Prioritize retrospectives for recurring issues
- Track effectiveness of action items from previous retrospectives
- Drive systemic fixes vs band-aids

---

### 5. Automation Opportunity

**Opportunity identified:** Automated generation of retrospective prep report on incident Slack channel

**Benefits:**
- Reduces manual prep work
- Ensures consistency
- Speeds up retro commander assignment and prep phase

**Next step:** Inês to check viability with SRE Team (Charola)

---

## Quality Involvement (To Be Defined with Vijay)

**Vera's action:** Align with Vijay on framework questions Quality wants to include

**Quality perspective to capture:**
- Testing gaps that contributed to incident
- Quality gate failures or bypasses
- Bug escape analysis (customer-reported vs internal detection)
- Quality metrics baseline for improvement tracking

**Integration model:**
- Quality joins retrospectives when incident involves quality issues
- Quality provides testing gap assessment and recommendations
- Quality tracks improvement over time (recurrence reduction)

---

## Stakeholder Alignment Plan

**Inês will share framework results with:**

1. **Vijay (Quality):**
   - Input on quality-related pillar questions
   - Alignment on Quality's role in retrospective process

2. **Charola (SRE):**
   - Validate asset identification workflow during incident response
   - Discuss prep report automation viability
   - Confirm SRE's role in assigning retro commanders

---

## Framework Pillars (Draft - To Be Validated)

**Current pillars (from earlier discussion, to be refined based on incident testing):**

1. **Detection & Monitoring**
   - Automatic vs customer-reported detection
   - SLO/alert effectiveness
   - Detection lead time

2. **Response & Communication**
   - MTTA (acknowledge and start working)
   - Status page communication (Public MTTA)
   - Stakeholder communication

3. **Troubleshooting & Root Cause**
   - Time to identify root cause
   - Depth of analysis
   - Contributing factors identified

4. **Recovery & Resolution**
   - MTTR
   - Service restoration approach
   - Verification of recovery

5. **Prevention & Learning**
   - Action items identified
   - Systemic fixes vs band-aids
   - Pattern identification (recurrence prevention)

6. **Process Compliance**
   - Retrospective SLA adherence
   - Documentation quality
   - Problem Management integration

**Next:** Validate and refine pillars based on live incident testing

---

## Action Items

### Inês
- [ ] Test framework against 3-5 additional live incidents to validate pillar questions
- [ ] Generate preparation scores once framework reaches solid 1st draft
- [ ] Share framework results with Vijay (Quality) for input
- [ ] Share framework results with Charola (SRE) for input and asset identification workflow validation
- [ ] Explore automated prep report generation on incident Slack channel with SRE Team

### Vera
- [ ] Align with Vijay (Quality) on framework questions to include from Quality perspective
- [ ] Define Quality involvement model (mandatory vs optional participation)

### Inês + Vera
- [ ] Finalize framework pillars and scoring criteria after validation phase
- [ ] Document operating model workflow with OLA targets
- [ ] Prepare April 13 presentation to VS Leaders & Engineering Managers

---

## Timeline

- **April 7-12:** Framework validation against additional incidents (Inês)
- **April 8-10:** Quality alignment discussion (Vera + Vijay)
- **April 13 (week of):** Present new model to VS Leaders & Engineering Managers
- **Q2 2026:** Pilot phase with selected value streams
- **Q3 2026:** Full rollout with baseline metrics collection
- **Q2 2027:** Achieve M3.5 and M3.6 targets

---

## Links

- Test case Confluence page: [Assessment RDINC-72566 - NATS Publishing Issue](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6174703908/Assessment+RDINC-72566+-+NATS+Publishing+Issue)
- Initiative tracker: `_initiative.md`
- Working plan: `plan.md`
- V2MOM measurements: M3.5 (RCA Completion & Lead Time), M3.6 (Incident Response Maturity)

---

*Meeting notes captured: 2026-04-07*
