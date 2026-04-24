# Change Management Patterns — Evidence Guide for Retrospective Analysis

**Version:** 1.1
**Last Updated:** 2026-04-24
**Purpose:** Reference guide for evaluating Change Management policy compliance in retrospectives

---

## Overview

This document provides evidence-based patterns to assess whether incident recovery actions followed Change Management policy. Use this as a reference when answering **Pillar 6, Q2** of the RCA Framework:

> **Q2: If the mitigation required a change (RFC), did it follow Change Management policy?**

**Sources:** 
- [Change Management - Cheat Sheet](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/5775949861/) — Official policy reference
- [SCENARIO 2 - Incident with system-wide impact](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4977459252/) — Recovery guidance
- Operations Reviews March-April 2026 — Compliance patterns analysis

---

## 📋 Change Management Policy Reference

### Change Types (Official Policy)

| Change Type | Key Characteristics | Catalog Requirement | Approval | Risk Level | Incident Usage |
|-------------|---------------------|---------------------|----------|------------|----------------|
| **Standard Change** | Pre-approved, repeatable, well-documented, low risk | Required (must be in Change Catalog) | Pre-approved | Low | Rare (routine operations only) |
| **Normal Change** | Planned changes, not urgent, requires formal approval | Required (must have catalog article) | CAB Approval required | Medium/High | Not used during incidents |
| **Emergency Change** | Immediate action needed for critical issues in **positive rings** (EA/GA) | Not Required | Expedited Approval (VS Leader written approval required) | High/Critical | **Primary incident recovery mechanism** |

**Emergency Change Policy Requirements** (per [Cheat Sheet](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/5775949861/)):
- "Immediate action is needed to mitigate critical issues affecting the availability, security, or functionality of the service in **positive rings**"
- "**Root Cause Analysis (RCA) is required** and conducted during the associated Incident Retrospective"
- "When the risk of acting is lower than the risk of doing nothing"
- Requires **written communication (e.g., Slack, Jira comment) before implementation by the VS Leader**

**Recovery Principles** (per [SCENARIO 2](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4977459252/)):
> "The primary goal during an incident is to **minimize customer impact** as quickly as possible. This means focusing on restoring service, not on fixing the underlying problem. Your first step should always be to figure out what options you have to mitigate the problem as fast as possible."

---

## ✅ Compliant Recovery Patterns

**Evidence of policy compliance:**

### 1. Emergency RFC with System-Wide Impact ✅
- ✅ Emergency RFC correctly declares **"system-wide impact"**
- ✅ Incident has measurable system-wide impact (SLO trigger, multiple customers, production ring affected)
- ✅ VS Leader approval documented (Slack message, Jira comment) **before implementation**
- ✅ Emergency classification matches incident severity

**Policy reference:** Emergency Change is for "critical issues affecting availability, security, or functionality of service in positive rings"

**Example:**
> "RFC-4522 used Emergency process for RDINC-75390 (customer-reported SEV1). System-wide SLO triggered. VS Leader approved via Slack before implementation. Emergency classification justified."

### 2. Rollback Considered as First Option ✅
- ✅ Rollback evaluated as primary recovery option (fastest path to restore service)
- ✅ If rollback not used, decision documented with clear justification (e.g., "multiple versions deployed since bug introduction")
- ✅ Decision follows policy principle: "first step should always be to figure out what options you have to mitigate as fast as possible"

**Policy reference:** [SCENARIO 2 - Recovery Measures](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4977459252/) explicitly states rollback should be considered first

**Example:**
> "Rollback considered but not possible — 2 days of deployments since bug introduction (RDMMS 1.0.250 → 1.0.255). Team opted for fix-forward with reduced bake times. Decision documented with clear justification."

### 3. Ring Progression Followed ✅
- ✅ Change executed in **OSALL → EA → GA** sequence
- ✅ Each ring validates the fix before moving to next ring
- ✅ No "Recovery Bypass" (skipping rings) **unless justified by SEV1 customer impact**

**Policy reference:** Standard ODC delivery lifecycle follows ring progression for safety validation

**Example:**
> "Fix deployed to OSALL (validation), then EA (early access testing), then GA (production). Ring progression followed policy."

### 4. RFC Linked to Incident (Traceability) ✅
- ✅ RFC linked to RDINC Jira issue using "is blocked by" relationship
- ✅ Recovery measures traceable from incident to change
- ✅ RFC number documented in retrospective

**Policy reference:** [SCENARIO 2 - Traceability of Recovery Measures](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4977459252/) requires linking

**Example:**
> "RFC-4728 linked to RDINC-78158 with 'is blocked by' relationship. Traceability maintained per policy."

### 5. Accurate Risk Classification ✅
- ✅ Emergency RFCs marked as **"High/Critical"** risk (per policy definition)
- ✅ Risk classification matches actual technical complexity
- ✅ No "Risk Creep" (artificially lowering risk to avoid scrutiny)

**Policy reference:** Emergency Change definition explicitly states "High/Critical" risk level

**Example:**
> "RFC-4457 marked as High Risk. Production database schema change during incident. Classification accurate per Emergency Change policy."

### 6. Fast Track with Justification ✅
- ✅ Fast Track usage documented with clear justification
- ✅ Urgency directly tied to SEV1/SEV2 customer impact
- ✅ Fast Track usage is exception, not pattern (<5% overall)

**Example:**
> "Fast Track used to skip baking period due to SEV1 customer impact (186 tenants unable to login). Justified by immediate business risk."

---

## 🚨 Non-Compliant Recovery Patterns

**Red flags indicating policy violations:**

### 1. Recovery Bypass 🔴 CRITICAL VIOLATION

**What it is:**
Emergency RFC executed **directly in GA (production)** without passing through OSALL/EA validation rings, and without documented justification.

**Why it matters:**
- Violates "Risk Multiplication" principle (every ring adds validation)
- Bypasses safety checks that catch secondary issues
- Introduces unvalidated changes directly into production
- **Policy requires ring progression unless explicitly justified by SEV1 severity**

**Evidence patterns:**
- ❌ Emergency executed only in `ring=3/GA` (0 executions in ring=1/OSALL or ring=2/EA)
- ❌ Ring distribution inverted: more volume in GA than OSALL
- ❌ Emergency count: OSALL=0, EA=0, GA=3
- ❌ **No documented justification for bypass (e.g., "SEV1 customer impact, VS Leader approved")**

**Historical data (Operations Reviews):**
- **March 5, 2026:** 3 out of 5 Emergency RFCs went directly to GA (Recovery Bypass)
- **April 16, 2026:** 4 out of 6 Emergency RFCs landed in GA (concentration in production)

**Example — Non-Compliant:**
> "RFC-4457 executed directly in GA to resolve RDINC-73895. No validation in OSALL or EA. No justification documented. Recovery Bypass due to time pressure."

**Example — Compliant with Justification:**
> "RFC-4457 bypassed OSALL/EA due to SEV1 customer impact affecting 50+ production environments (186 tenants unable to login for 2 hours). Bypass approved by VS Leader via Slack at 02:45 UTC. Post-incident action: create runbook for similar scenarios (RDPIDT-3599)."

---

### 2. Emergency RFC without System-Wide Impact 🔴 CRITICAL VIOLATION

**What it is:**
Emergency RFC used for incident that does **not** have system-wide impact (single tenant, isolated region, no SLO trigger).

**Why it matters:**
- **Policy explicitly states** Emergency is for "critical issues affecting availability, security, or functionality in **positive rings**" (implying system-wide scope)
- Using Emergency for isolated incidents normalizes risk-taking and bypasses proper approval
- Creates precedent for future policy violations
- **Violates VS Leader approval requirement** (Emergency requires written approval; single-tenant issues don't warrant VS escalation)

**Evidence patterns:**
- ❌ Emergency RFC linked to incident marked **"Without system-wide impact"**
- ❌ Emergency RFC for **customer-reported** issue affecting single customer/tenant
- ❌ Emergency RFC with **"Internal"** classification but no system-wide SLO trigger
- ❌ Incident declaration shows "System-wide impact: No" but Emergency RFC used

**Historical data (Operations Reviews):**
- **April 16, 2026:** 2 out of 6 Emergency RFCs classified as "Without system-wide impact" (RDINC-78358, RDINC-78052)
- **March 5, 2026:** 3 out of 5 Emergency RFCs did not meet system-wide criteria

**Example — Non-Compliant:**
> "RFC-4536 used Emergency process for RDINC-78358 (customer-reported, single tenant affected). Incident classification: 'Without system-wide impact'. Policy violation — Emergency requires system-wide scope per policy."

**Example — Compliant:**
> "RFC-4522 used Emergency process for RDINC-75390 (customer-reported SEV1). System-wide SLO triggered, 186 tenants across all 13 regions affected. Emergency classification correct per policy."

---

### 3. Risk Classification Creep ⚠️ POLICY VIOLATION

**What it is:**
Emergency changes marked as **"Low Risk"** or **"Medium Risk"** instead of mandatory **"High/Critical"** classification.

**Why it matters:**
- **Violates policy definition:** Emergency Changes are explicitly defined as "High/Critical" risk per [Cheat Sheet](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/5775949861/)
- Masks actual technical complexity and danger
- Reduces visibility for reviewers and VS Leaders
- Creates false sense of safety and undermines approval process

**Evidence patterns:**
- ❌ Emergency RFC marked as **"Low Risk"** or **"Medium Risk"** (policy violation — must be High/Critical)
- ❌ Production database changes marked as "Low Risk"
- ❌ Deployment affecting multiple services marked as "Low Risk"

**Historical data (Operations Reviews):**
- **March 5, 2026:** 4 out of 5 Emergency RFCs marked as "Low Risk" (83% Low Risk overall) — **policy violation**
- Pattern: Teams intentionally minimizing risk levels to avoid scrutiny

**Example — Non-Compliant:**
> "RFC-4457 (Emergency) marked as Low Risk. Actual change: production database schema migration. Risk classification inaccurate — **violates policy requirement that Emergency = High/Critical**."

**Example — Compliant:**
> "RFC-4457 (Emergency) marked as High Risk. Production database schema migration with potential downtime. Risk classification accurate per Emergency Change policy definition."

---

### 4. Fast Track Overuse ⚠️ WARNING

**What it is:**
Fast Track usage significantly above baseline (<5% target), indicating overuse or misuse.

**Why it matters:**
- Fast Track skips baking period (safety validation window)
- Intended as "last resort", not standard practice
- High usage indicates process pressure or inadequate planning

**Evidence patterns:**
- ❌ Fast Track usage >15% of all changes
- ❌ Fast Track used without clear justification documented
- ❌ Fast Track used for planned operations (not urgent fixes)

**Historical data (Operations Reviews):**
- **April 2, 2026:** Fast Track usage at **22%** (highest observed, target <5%)
- **March 19, 2026:** Fast Track at 5% (on target)
- **March 5, 2026:** Fast Track reduced to 3.96% from 17.24% (improvement)

**Example — Non-Compliant:**
> "Fast Track used for RFC-4536. No justification documented. Planned API key rotation, not urgent."

**Example — Compliant:**
> "Fast Track used for RFC-4522 to skip baking period. Justified by SEV1 customer impact requiring immediate fix."

---

### 5. Shadow SDLC Pattern 🔶 PROCESS GAP

**What it is:**
Manual Normal RFCs used for **planned deployments** that should use **automated pipelines** (Standard Changes).

**Why it matters:**
- **SOC 2 compliance risk** — planned deployments should use pre-approved automated pipelines
- Increases manual overhead for CAB
- Higher risk of human error in production
- Indicates gap between available automation and actual usage

**Evidence patterns:**
- ❌ 65-76% of Normal Changes used for **"Planned Operations"** (should be <30%)
- ❌ Routine deployments (API key rotation, config updates, code deployments) using manual RFCs
- ❌ Planned work not flowing through approved CI/CD pipelines

**Historical data (Operations Reviews):**
- **April 16, 2026:** 76.92% Normal Planned (highest observed, 10pp above baseline)
- **April 2, 2026:** 73% Normal Planned (SOC 2 risk flagged)
- **March 19, 2026:** 55.56% Normal Planned (improvement)
- **March 5, 2026:** 65% Normal Planned

**Example — Process Gap:**
> "Mitigation deployed via manual RFC-4468 (Normal Change, Planned Operation). Should have used automated CI/CD pipeline (Standard Change). Shadow SDLC pattern."

**Note:** This is a **process improvement opportunity**, not a policy violation during incident recovery. However, if manual deployment contributed to incident (human error), it should be flagged.

---

## 📊 Evidence Collection Checklist

When evaluating Change Management compliance, gather:

### RFC Information
- [ ] RFC number(s) used for mitigation
- [ ] RFC type: Emergency, Normal, Standard
- [ ] Risk classification: Low, Medium, High, Critical
- [ ] Fast Track usage: Yes/No + justification
- [ ] RFC linked to RDINC? ("is blocked by" relationship)

### Incident Context
- [ ] System-wide impact declared? Yes/No
- [ ] Incident severity: SEV1, SEV2, SEV3
- [ ] Customer impact: Single customer vs multiple vs system-wide
- [ ] SLO trigger: System-wide SLO vs service-specific vs none
- [ ] Positive ring affected? (EA/GA)

### VS Leader Approval (Emergency RFC only)
- [ ] VS Leader approval documented? (Slack message, Jira comment)
- [ ] Approval given **before** implementation?
- [ ] Written communication preserved?

### Recovery Decision
- [ ] Rollback considered as first option?
- [ ] If rollback not used, justification documented?
- [ ] Decision follows policy principle: "minimize customer impact as quickly as possible"?

### Ring Progression
- [ ] Ring distribution: OSALL → EA → GA
- [ ] Recovery Bypass? Yes/No + justification
- [ ] If bypass, SEV1 customer impact justification documented?
- [ ] Executions per ring: ring=1/OSALL, ring=2/EA, ring=3/GA

### Policy Compliance
- [ ] Emergency criteria met? (positive ring impact + system-wide scope per policy)
- [ ] Risk classification accurate? (Emergency must be High/Critical per policy)
- [ ] Fast Track justified?
- [ ] Ring progression followed or bypass justified?
- [ ] Traceability maintained (RFC linked to RDINC)?

---

## 🎯 Scoring Guidance for Pillar 6, Q2

**✅ Compliant (1.0 point):**
- Emergency RFC correctly declared system-wide impact (positive ring + multiple tenants/regions)
- VS Leader approval documented **before** implementation (Slack/Jira)
- Rollback considered as first option (documented decision)
- Ring progression followed (OSALL → EA → GA) **OR** bypass justified by SEV1 severity
- Risk classification accurate (Emergency = High/Critical per policy)
- RFC linked to RDINC ("is blocked by" relationship)
- Fast Track justified (if used)

**⚠️ Partial Compliance (0.5 points):**
- Emergency RFC used but system-wide impact ambiguous (e.g., "multiple tenants" but unclear scope)
- VS Leader approval present but timing unclear (approved after implementation?)
- Rollback mentioned but decision rationale weak
- Recovery Bypass documented **with clear justification** (e.g., "SEV1 customer impact, 186 tenants unable to login, VS Leader approved")
- Risk classification slightly off but defensible (e.g., "High" instead of "Critical")
- RFC linkage missing but RFC number documented in retrospective
- Fast Track used but justification weak or unclear

**❌ Non-Compliant (0.0 points):**
- Emergency RFC without system-wide impact (**policy violation** — single tenant/isolated region)
- No VS Leader approval documented
- Rollback not considered (violates policy: "first step should be to figure out mitigation options")
- Recovery Bypass without justification
- Risk Classification Creep (Emergency marked Low/Medium Risk — **policy violation**, must be High/Critical)
- No RFC created for production change
- Fast Track overuse without justification
- No traceability (RFC not linked to RDINC)

**🚫 N/A:**
- Mitigation didn't require RFC (e.g., service restart, config change via feature flag, observability change)
- Incident in negative ring (dev/stage) — Change Management policy focuses on positive rings

---

## Related V2MOM Initiatives

Change Management compliance supports:

- **M2.1 (Enable CI/CD Compliance)** — Consolidate Change Catalog with clear RFC criteria and CI/CD guidance
- **M2.2 (Empower Reviewers)** — Define reviewer framework with explicit approval criteria, including Fast Track usage guidelines

---

## Reference Materials

**Operations Reviews (Change Management sections):**
- [April 16, 2026](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6224150753/April+16+2026#Change-Management-Data)
- [April 2, 2026](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6155436039/April+2+2026#Change-Management-Data)
- [March 19, 2026](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6083674313/March+19+2026#Change-Management-Data)
- [March 5, 2026](https://outsystemsrd.atlassian.net/wiki/spaces/EEO/pages/6014402771/March+05+2026#Change-Management-Data)

**Related Documents:**
- [RCA-FRAMEWORK-PILLARS.md](./RCA-FRAMEWORK-PILLARS.md) — Full framework
- Change Management Policy — Internal reference (link TBD)
- SOC 2 Compliance Procedures — Internal reference (link TBD)

---

## Changelog

**Version 1.1 (2026-04-24)**
- **Aligned with official Change Management policy documentation**
  - Added Change Types reference table from [Cheat Sheet](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/5775949861/)
  - Integrated [SCENARIO 2](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4977459252/) recovery guidance
- **Enhanced compliance patterns:**
  - Added "Rollback Considered" as compliant pattern (policy requires considering rollback first)
  - Added "RFC Linked to Incident" traceability requirement
  - Clarified VS Leader approval requirement for Emergency RFCs
  - Updated Risk Classification Creep to reflect policy violation (Emergency must be High/Critical)
- **Expanded evidence checklist:**
  - Added VS Leader approval check
  - Added rollback consideration check
  - Added RFC linkage check
  - Added positive ring scope check
- **Updated scoring guidance with more specific criteria**

**Version 1.0 (2026-04-20)**
- Initial version created to support RCA Framework v1.4
- Patterns derived from Operations Reviews March-April 2026
- Evidence collection guidance for Pillar 6, Q2

---

**Document Owner:** Inês Matos
**Status:** Active — Reference for retrospective auditing
