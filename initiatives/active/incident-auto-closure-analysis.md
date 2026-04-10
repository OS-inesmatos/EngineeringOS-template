# Incident Auto-Closure Analysis

*Análise do problema de incidentes "presos" no estado Solved*

---

## 🎯 Problema

**Observação:** Muitos incidentes não system-wide ficam "presos" no estado Solved e nunca são movidos para Closed.

**Impacto:**
- Métricas de closure rate distorcidas
- Backlog visual de incidentes "abertos" (tecnicamente em Solved, mas não Closed)
- Falta de hygiene no processo

---

## 🔍 Root Cause Analysis

### O que descobrimos

**Da documentação do RDINC workflow:**
- Backlog → Team Assigned → Troubleshooting → **Solved** → (Retrospective se system-wide) → Closed
- **Solved = customer unblocked** (recovery phase completa)
- **Closed = administrative closure** (investigation phase completa)

**Da documentação dos Jira fields:**
- **Root Cause Categorization** é mandatory quando transitioning para Solved
- Campo é marcado com **[Change Failure Rate ⚡]** — usado para CFR calculation
- **Exceções:** Incident Type = Alert OU Root Cause Categorization = Customer Issue

### Por que ficam presos em Solved?

1. **Solved sinaliza "done" para a equipa** — customer unblocked, problema resolvido
2. **Root Cause Categorization já foi preenchido** — mandatory field já cumprido
3. **Closed não adiciona valor percebido** — é visto como administrative overhead
4. **Sem reminder ou motivação** para mover para Closed
5. **Para non-system-wide incidents**, não há retrospective para forçar revisão

**Resultado:** Incidentes acumulam em Solved indefinidamente.

---

## 🧩 A Contradição Aparente

**User feedback inicial:** "de start até solved queremos é desbloquear o cliente. de solved a closed é que podem fazer uma investigação sobre o que aconteceu"

**Mas a realidade:**
- Root Cause Categorization é **mandatory at Solved transition**
- Investigation já acontece **antes** de Solved (para preencher o campo)
- Solved → Closed não requer investigation adicional

### Por que Root Cause é mandatory at Solved?

**Para cálculo do Change Failure Rate (CFR):**
- CFR é calculado com base em incidents que entraram em Solved
- Root Cause Categorization determina se incident conta como "change failure"
- Se fosse optional at Solved, CFR data estaria incompleto

**Valores de Root Cause Categorization:**
- Infrastructure issues
- Application issues
- Deployment issues → **indica change failure**
- Security Issues
- Operational Issues
- Configuration issues
- Missing feature
- Customer Issue → **exception, não conta para CFR**

---

## ✅ Proposta de Solução

### Automação: Auto-Close Non-System-Wide Incidents

**Critérios para auto-close:**

```
IF incident.status == "Solved"
AND incident.system_wide_impact == false
AND incident.root_cause_categorization IS NOT NULL
AND days_in_solved >= 7
THEN transition to "Closed"
```

**Lógica:**

1. **Status = Solved** → recovery phase completa, customer unblocked
2. **System-wide impact = false** → não requer retrospective
3. **Root Cause filled** → mandatory field já preenchido, CFR data captured
4. **7 days in Solved** → tempo suficiente para qualquer follow-up ad-hoc

### Implementação

**Opção A: Jira Automation Rule**

```yaml
Trigger: Scheduled (runs daily)
Condition:
  - Issue status = Solved
  - System-wide Impact = No
  - Root Cause Categorization is not EMPTY
  - Status changed to Solved more than 7 days ago
Action:
  - Transition issue to Closed
  - Add comment: "Auto-closed after 7 days in Solved (non-system-wide incident)"
```

**Opção B: Script via acli**

```bash
# Query incidents stuck in Solved
acli jira getIssueList \
  --project RDINC \
  --jql "status = Solved AND 'System-wide Impact' = No AND 'Root Cause Categorization' is not EMPTY AND statusCategoryChangedDate <= -7d" \
  --outputType 999

# Transition to Closed
acli jira transitionIssue \
  --issue RDINC-123 \
  --transition "Close" \
  --comment "Auto-closed after 7 days in Solved"
```

---

## 📊 Expected Impact

**Before:**
- ~200+ incidents stuck in Solved (estimation)
- Average age in Solved: 30+ days
- Closure rate: ~60%

**After (projected):**
- <10 incidents in Solved at any time
- Average age in Solved: <7 days
- Closure rate: ~95%

---

## 🚨 Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Auto-close incidents que precisavam de follow-up | 7-day window permite tempo para action items serem criados |
| Equipas perdem visibilidade de incidents ativos | Solved já sinaliza "done" — Closed é administrative |
| CFR data incorreto | Root Cause já filled at Solved (mandatory), não afeta CFR |
| System-wide incidents auto-closed por engano | Automation explicitly excludes system-wide = true |

---

## 🔄 Alternative: Change When Root Cause is Mandatory

**Not recommended** porque:

1. **Root Cause mandatory at Solved é correto** — CFR needs this data point
2. **Solved = recovery complete** — root cause deve ser conhecido para confirmar resolution
3. **Mudar para "mandatory at Closed"** quebraria CFR calculation

**Se quiséssemos fazer isto:**
- Root Cause ficaria optional at Solved
- CFR calculation teria de mudar para usar Closed incidents
- Mas Closed demora muito mais tempo → CFR metrics atrasados
- E non-system-wide incidents continuariam stuck (agora sem Root Cause filled)

---

## 📋 Next Steps

1. **Validate automation logic** com Valentim/Rebecca
2. **Create Jira Automation rule** com 7-day threshold
3. **Monitor for 2 weeks** — check for false positives
4. **Tune threshold** se necessário (7 days vs 14 days)
5. **Backfill historical incidents** — run script to close old Solved incidents

---

## 🔗 Related Documentation

- [RDINC Workflow and Statuses](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/5600378890/RDINC+Workflow+and+Statuses)
- [What does an ODC Incident look like in Jira?](https://outsystemsrd.atlassian.net/wiki/spaces/RKB/pages/4696212738/What+does+an+ODC+Incident+look+like+in+Jira)
- M3.3 - Triage Models & OLAs (RSA-728)

---

*Análise completada: 2026-03-30*
