# Change Management Patterns — Evidence Guide for Retrospective Analysis

**Version:** 1.0
**Last Updated:** 2026-04-20
**Purpose:** Reference guide for evaluating Change Management policy compliance in retrospectives

---

## Overview

This document provides evidence-based patterns to assess whether incident recovery actions followed Change Management policy. Use this as a reference when answering **Pillar 6, Q2** of the RCA Framework:

> **Q2: If the mitigation required a change (RFC), did it follow Change Management policy?**

**Source:** Operations Reviews March-April 2026, Change Management data analysis

---

## ✅ Compliant Recovery Patterns

**Evidence of policy compliance:**

### 1. Emergency RFC with System-Wide Impact
- ✅ Emergency RFC correctly declares **"system-wide impact"**
- ✅ Incident has measurable system-wide impact (SLO trigger, multiple customers, production ring affected)
- ✅ Emergency classification matches incident severity

**Example:**
> "RFC-4522 used Emergency process for RDINC-75390 (customer-reported SEV1). System-wide SLO triggered. Emergency classification justified."

### 2. Ring Progression Followed
- ✅ Change executed in **OSALL → EA → GA** sequence
- ✅ Each ring validates the fix before moving to next ring
- ✅ No "Recovery Bypass" (skipping rings)

**Example:**
> "Fix deployed to OSALL (validation), then EA (early access testing), then GA (production). Ring progression followed policy."

### 3. Accurate Risk Classification
- ✅ Risk classification matches actual technical complexity
- ✅ High-risk production changes marked as **"High Risk"**
- ✅ No "Risk Creep" (artificially lowering risk to avoid scrutiny)

**Example:**
> "RFC-4457 marked as High Risk. Production database schema change. Classification accurate."

### 4. Fast Track with Justification
- ✅ Fast Track usage documented with clear justification
- ✅ Urgency directly tied to SEV1/SEV2 customer impact
- ✅ Fast Track usage is exception, not pattern (<5% overall)

**Example:**
> "Fast Track used to skip baking period due to SEV1 customer impact. Justified by immediate business risk."

---

## 🚨 Non-Compliant Recovery Patterns

**Red flags indicating policy violations:**

### 1. Recovery Bypass 🔴 CRITICAL

**What it is:**
Emergency RFC executed **directly in GA (production)** without passing through OSALL/EA validation rings.

**Why it matters:**
- Violates "Risk Multiplication" principle (every ring adds validation)
- Bypasses safety checks that catch secondary issues
- Introduces unvalidated changes directly into production

**Evidence patterns:**
- ❌ Emergency executed only in `ring=3/GA` (0 executions in ring=1/OSALL or ring=2/EA)
- ❌ Ring distribution inverted: more volume in GA than OSALL
- ❌ Emergency count: OSALL=0, EA=0, GA=3

**Historical data (Operations Reviews):**
- **March 5, 2026:** 3 out of 5 Emergency RFCs went directly to GA (Recovery Bypass)
- **April 16, 2026:** 4 out of 6 Emergency RFCs landed in GA (concentration in production)

**Example — Non-Compliant:**
> "RFC-4457 executed directly in GA to resolve RDINC-73895. No validation in OSALL or EA. Recovery Bypass due to time pressure."

**Example — Compliant with Justification:**
> "RFC-4457 bypassed OSALL/EA due to SEV1 customer impact affecting 50+ production environments. Bypass approved by SRE Lead. Post-incident action: create runbook for similar scenarios."

---

### 2. Emergency RFC without System-Wide Impact 🔴 CRITICAL

**What it is:**
Emergency RFC used for incident that does **not** have system-wide impact.

**Why it matters:**
- Emergency process is reserved for system-wide incidents (policy requirement)
- Using Emergency for isolated incidents normalizes risk-taking
- Creates precedent for future policy violations

**Evidence patterns:**
- ❌ Emergency RFC linked to incident marked **"Without system-wide impact"**
- ❌ Emergency RFC for **customer-reported** issue affecting single customer
- ❌ Emergency RFC with **"Internal"** classification but no system-wide SLO trigger

**Historical data (Operations Reviews):**
- **April 16, 2026:** 2 out of 6 Emergency RFCs classified as "Without system-wide impact" (RDINC-78358, RDINC-78052)
- **March 5, 2026:** 3 out of 5 Emergency RFCs did not meet system-wide criteria

**Example — Non-Compliant:**
> "RFC-4536 used Emergency process for RDINC-78358 (customer-reported). Incident classification: 'Without system-wide impact'. Policy violation."

**Example — Compliant:**
> "RFC-4522 used Emergency process for RDINC-75390 (customer-reported SEV1). System-wide SLO triggered, multiple production stamps affected. Emergency classification correct."

---

### 3. Risk Classification Creep ⚠️ WARNING

**What it is:**
Emergency or high-impact changes marked as **"Low Risk"** to avoid scrutiny or accelerate approvals.

**Why it matters:**
- Masks actual technical complexity and danger
- Reduces visibility for reviewers and CAB
- Creates false sense of safety

**Evidence patterns:**
- ❌ Emergency RFC marked as **"Low Risk"**
- ❌ Production database changes marked as "Low Risk"
- ❌ Deployment affecting multiple services marked as "Low Risk"

**Historical data (Operations Reviews):**
- **March 5, 2026:** 4 out of 5 Emergency RFCs marked as "Low Risk" (83% Low Risk overall)
- Pattern: Teams intentionally minimizing risk levels to avoid scrutiny

**Example — Non-Compliant:**
> "RFC-4457 (Emergency) marked as Low Risk. Actual change: production database schema migration. Risk classification inaccurate."

**Example — Compliant:**
> "RFC-4457 (Emergency) marked as High Risk. Production database schema migration with potential downtime. Risk classification accurate."

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
- [ ] Risk classification: Low, Medium, High
- [ ] Fast Track usage: Yes/No + justification

### Incident Context
- [ ] System-wide impact declared? Yes/No
- [ ] Incident severity: SEV1, SEV2, SEV3
- [ ] Customer impact: Single customer vs multiple vs system-wide
- [ ] SLO trigger: System-wide SLO vs service-specific vs none

### Ring Progression
- [ ] Ring distribution: OSALL → EA → GA
- [ ] Recovery Bypass? Yes/No + justification
- [ ] Executions per ring: ring=1/OSALL, ring=2/EA, ring=3/GA

### Policy Compliance
- [ ] Emergency criteria met? (system-wide impact required)
- [ ] Risk classification accurate?
- [ ] Fast Track justified?
- [ ] Ring progression followed?

---

## 🎯 Scoring Guidance for Pillar 6, Q2

**✅ Compliant (1 point):**
- Emergency RFC correctly declared system-wide impact
- Followed ring progression (OSALL → EA → GA)
- Risk classification accurate
- Fast Track justified (if used)

**⚠️ Partial Compliance (0.5 points):**
- Recovery Bypass documented **with clear justification** (e.g., "SEV1 customer impact, approved by SRE Lead")
- Fast Track used but justification weak or unclear
- Risk classification slightly inaccurate but not egregious

**❌ Non-Compliant (0 points):**
- Emergency without system-wide impact (policy violation)
- Recovery Bypass without justification
- Risk Classification Creep (Emergency marked Low Risk)
- Fast Track overuse without justification
- No RFC created for production change

**🚫 N/A:**
- Mitigation didn't require RFC (e.g., restart, rollback, config change via feature flag)

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

**Version 1.0 (2026-04-20)**
- Initial version created to support RCA Framework v1.4
- Patterns derived from Operations Reviews March-April 2026
- Evidence collection guidance for Pillar 6, Q2

---

**Document Owner:** Inês Matos
**Status:** Active — Reference for retrospective auditing
