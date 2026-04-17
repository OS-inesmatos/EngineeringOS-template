# Operations Review — Retrospective Transformation
**Speech for Ops Review**  
**Date:** 2026-04-16  
**Speaker:** Inês Matos (Process Engineering)  
**Duration:** ~3-4 minutes
**Tone:** Executive, outcome-focused, confident but collaborative

---

Today I want to give you a quick update on our next steps for Incident Response. We are proposing two fundamental changes:

The first is the retirement of the Internal Communications Leader role. Experience has shown us that this role hasn’t delivered the value we expected. So, we're returning to a model where SRE provides incident context and Service Controllers handle external communications. Communication MUST BE a first-class citizen, and we need to streamline it and automate it as possible.

Second, we are redesigning the Retrospective Model to address operational bottlenecks and promote collaborative learning from incidents:
  
We will ask R&D Teams to be fully accountable for their quality and learning, as they have more context about their systems and ongoing challenges.

This means R&D Teams will own their Retrospectives, while making it a joint effort. Areas like SRE, Global Support, Quality or Process Engineering should be invited to collaborate when valuable. We will help you by giving you guided autonomy through a framework that covers pillars like detection, quality, reliability, and process.

The way you organize, is completely up to you (either offline, either having an working session). This is about involving the right people at the right time.

The core message that we want to share is that what matters is the improvement cycle. We believe success depends on our ability to learn from incidents, identify what needs to change, and execute those changes.

This is the outcome we should care about, and that's why we will also act on bureaucracy by, for example, removing the mandatory Readouts.

Process Engineering will play two roles: participate in this exercise when our contribution is valuable, and track patterns across retrospectives to identify systemic issues. The idea is to bring metrics to future Operations Reviews — what we're learning, where incidents recur, and what actions we're taking to close those gaps.

We're aligning this plan with SRE, Quality, Global Support, and Product Leadership. In the next few weeks we will give you more details about the timeline of implementation.


---

**Key messages to land (for slide):**

**1. The Outcome We're Solving For**
   - Faster learning loops — from incident to improvement
   - Fewer recurring incidents — better execution on action items
   - Better use of engineering capacity — less process overhead

**2. What Changes: Ownership Shift**
   - Teams own retrospectives (deepest context on their systems)
   - Simple flow: Team executes → Manager reviews → VSL approves
   - No more waiting for SRE. No more mandatory readouts.

**3. What Matters: The Improvement Cycle**
   - Learn from incidents → identify what must change → execute improvements
   - **Make it as lean as you need — as long as you're getting the improvements**
   - Outcome over process

**4. Collaborative, Not Bureaucratic**
   - SRE, Quality, GS, Process Eng join when they add value (partners, not gatekeepers)
   - Framework to guide teams (detection, response, recovery, prevention)
   - Process Eng tracks patterns → surfaces systemic issues → brings to Ops Review

**5. Philosophy: Autonomy with Accountability**
   - Your teams own their learning and improvements
   - We support when valuable, not because it's mandated
   - Metrics visible in future Operations Reviews

---

**Tone notes:**
- Empowering, not prescriptive
- Trust the teams, don't micromanage
- Clear on outcomes, flexible on execution
- Acknowledge this is a shift, invite collaboration

---

## APPENDIX: Q&A Preparation

If questions come up, use these answers:

### Q: Why now?
**A:** Current model is operationally unsustainable. SRE can't scale, reviewer pool shrinking. 72-day lead time means we're learning too slowly — context goes stale, action items don't get executed, incidents recur.

### Q: How do we ensure quality without reviewers?
**A:** Framework-based assessment against 6 pillars (detection, response, troubleshooting, recovery, prevention, process). Objective scoring 0-100%, threshold >70% for approval. Process Eng facilitates working sessions initially, validates quality through sampling.

### Q: What if my EM/TL doesn't know how to do RCA?
**A:** We provide training (Brown Bags), working session facilitation (Process Eng leads initially), and framework guidance (tells you exactly what questions to answer). Progressive autonomy — we support until teams are self-sufficient.

### Q: What happens to SRE's role?
**A:** SRE transitions from execution to advisory. They attend working sessions when requested, provide guidance, but no longer lead all retrospectives. Frees up SRE capacity for strategic work.

### Q: Will this slow down incident response?
**A:** No — retrospectives happen **after** incident closure. Incident response process unchanged. This only affects post-incident learning, and makes it faster (45 days vs 72 days).

### Q: What about Global Support?
**A:** GS joins retrospectives when they have context or questions. GS handles customer-facing RCA communication based on retrospective outcomes. Role split: Engineering owns technical content, GS owns customer communication.

### Q: How does this relate to M3.4 (Problem Management)?
**A:** Retrospectives focus on individual incident learning. M3.4 (Problem Management) focuses on systemic patterns across multiple incidents. Retrospectives feed into M3.4 — framework detects recurrence, flags patterns for systemic investigation.

### Q: Can teams skip the working session?
**A:** Yes, if pre-assessment score is >70% AND all pillars are strong. This is progressive autonomy — high-maturity teams can operate independently. Process Eng approves skip requests.

### Q: What's the framework based on?
**A:** Production Readiness Checklist, industry best practices (Google SRE Book, incident response frameworks), and OutSystems reliability platform principles. 6 pillars: Detection & Monitoring, Response & Communication, Troubleshooting & Root Cause, Recovery & Resolution, Prevention & Learning, Process Compliance.

---

**Estimated speaking time:** 3-4 minutes (without Q&A)  
**Tone:** Executive, outcome-focused, confident but collaborative

---

**Key messages to emphasize:**
1. **Operational necessity** — current model unsustainable
2. **Team ownership** — accountability where it belongs
3. **Quality maintained** — framework ensures consistency
4. **Faster learning** — 40% lead time reduction
5. **Support provided** — not throwing teams in the deep end

**What NOT to say:**
- Don't apologize for the change
- Don't focus on process details (save for Confluence docs)
- Don't oversell — acknowledge this is a shift and we'll adjust based on feedback
- Don't criticize SRE or volunteers — frame as "scaling the capability, not blaming individuals"

---
