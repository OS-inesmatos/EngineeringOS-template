# Retrospective Metrics - System-wide Impact Issues Only
## Últimos 6 Meses

**Data de Análise:** 2026-03-11
**Critério:** Issues com "System-wide impact? = Yes" movidos para "Retrospective Completed" nos últimos 6 meses
**Total de Issues:** 18

---

## 📊 Resumo por Issue

| Issue | Summary | Solved (dias) | Retro In Progress (dias) | Retro Completed (dias) | Total (dias) |
|-------|---------|---------------|---------------------------|------------------------|--------------|
| RDINC-72566 | Not able to Publish all web apps | 7.01 | 16.18 | 11.81 | **34.99** |
| RDINC-67391 | GET portfolios/v1/deployed-assets fails 500 | 34.61 | 31.33 | 0.02 | **65.96** |
| RDINC-65898 | Static entities with reserved keywords | 5.11 | 57.25 | 0.01 | **62.37** |
| RDINC-65652 | Cannot publish - Error OS-DPL-40802 | 2.32 | 68.79 | 20.99 | **92.10** |
| RDINC-65439 | NATS leaf and NATS2CRD degradation | 7.36 | 54.04 | 0.00 | **61.40** |
| RDINC-64639 | End-users cannot set/reset passwords | 0.00 | 101.13 | 1.98 | **103.11** |
| RDINC-64612 | [TEST - Please Ignore] | 0.00 | 0.00 | 0.01 | **0.01** |
| RDINC-64437 | PE users cannot login - Community Provider | 19.73 | 84.23 | 1.80 | **105.76** |
| RDINC-64289 | Deployment Timeouts with External Libraries | 17.16 | 81.68 | 0.02 | **98.86** |
| RDINC-63743 | Unable to log in on ODC Personal Editions | 8.09 | 41.80 | 63.12 | **112.99** |
| RDINC-63691 | Tenant provisioning bug in realm creation | 0.00 | 44.77 | 65.09 | **109.86** |
| RDINC-63322 | NATS issue affecting Deployments, Timers | 30.24 | 83.95 | 5.84 | **120.03** |
| RDINC-62612 | osall-tenant-provision-stuck | 35.56 | 83.22 | 6.80 | **125.58** |
| RDINC-61943 | Spike in build timeouts - NATS messages | 10.56 | 91.04 | 0.00 | **101.60** |
| RDINC-61911 | Tenant provisioning stuck osall ap-southeast-1 | 40.95 | 83.22 | 6.80 | **130.97** |
| RDINC-61899 | SAP connections broken after QE deployment | 12.22 | 65.02 | 1.18 | **78.42** |
| RDINC-61732 | OSALL 1CP failing - deployment timeout | 8.80 | 75.04 | 49.02 | **132.86** |
| RDINC-61437 | tenant-provision-stuck | 44.77 | 83.22 | 6.80 | **134.79** |

---

## 🎯 Estatísticas Agregadas

### Tempo Médio por Estado
| Estado | Média | Mediana | Máximo |
|--------|-------|---------|--------|
| **Solved** | 15.80 dias | 10.56 dias | 44.77 dias |
| **Retrospective In Progress** | 63.66 dias | 68.79 dias | 101.13 dias |
| **Retrospective Completed** | 13.41 dias | 6.80 dias | 65.09 dias |
| **TOTAL MÉDIO** | **92.87 dias** | **98.86 dias** | **134.79 dias** |

### 📈 Issues Mais Demorados (Top 5)
1. **RDINC-61437** - 134.79 dias (tenant-provision-stuck)
2. **RDINC-61732** - 132.86 dias (OSALL 1CP failing)
3. **RDINC-61911** - 130.97 dias (Tenant provisioning stuck)
4. **RDINC-62612** - 125.58 dias (osall-tenant-provision-stuck)
5. **RDINC-63322** - 120.03 dias (NATS issue affecting Deployments)

### ⚡ Issues Mais Rápidos (Top 5)
1. **RDINC-64612** - 0.01 dias (TEST issue)
2. **RDINC-72566** - 34.99 dias (Cannot Publish web apps)
3. **RDINC-65439** - 61.40 dias (NATS degradation)
4. **RDINC-65898** - 62.37 dias (Static entities with reserved keywords)
5. **RDINC-67391** - 65.96 dias (GET portfolios fails)

### 🔴 Bottlenecks Identificados

**"Retrospective In Progress" é o maior bottleneck:**
- Média: **63.66 dias** (mais do que o dobro dos outros estados combinados)
- Mediana: **68.79 dias**
- 7 issues ultrapassaram os **80 dias** neste estado

**Issues com mais de 100 dias no estado "Retro In Progress":**
- RDINC-64639: 101.13 dias

**Issues com mais de 60 dias no estado "Retro Completed":**
- RDINC-63691: 65.09 dias
- RDINC-63743: 63.12 dias

---

## 📁 Ficheiros Gerados

1. **CSV Completo (30 issues):**
   - `retrospectives/data/retrospective-metrics-20260311-113839.csv`

2. **CSV Filtrado (18 issues com System-wide impact):**
   - `retrospectives/data/retrospective-metrics-system-wide-20260311-114536.csv`

3. **Lista de Issues:**
   - `retrospectives/scripts/issues-system-wide.txt`

---

## 💡 Conclusões

1. **Processo Demorado:** Média de ~93 dias (3 meses) desde Solved até Closed
2. **Bottleneck Principal:** Estado "Retrospective In Progress" (64 dias em média)
3. **Variação Grande:** De 0.01 dias até 134.79 dias
4. **Padrão Comum:** Muitos issues com ~83 dias em "Retro In Progress" (possível ponto de estagnação)

---

**Gerado em:** 2026-03-11 11:45
**Comando usado:** `.\Get-RetroMetrics.ps1 -IssueKeys (Get-Content issues-list.txt)`
