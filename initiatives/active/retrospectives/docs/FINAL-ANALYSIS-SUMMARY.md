# Análise Final - Retrospective Process Metrics
## Issues com System-wide Impact = Yes (últimos 6 meses)

**Data:** 2026-03-11
**Issues Analisados:** 18
**Período:** Setembro 2025 - Março 2026

---

## 🎯 Métricas Principais

### Tempo Médio em Cada Estado do Processo

| Estado | Tempo Médio | Mediana | % do Total |
|--------|-------------|---------|------------|
| **Solved** | 15.80 dias | 10.56 dias | 17% |
| **Retrospective In Progress** | 63.66 dias | 68.79 dias | 69% ⚠️ |
| **Retrospective Completed** | 13.41 dias | 6.80 dias | 14% |
| **TOTAL** | **92.87 dias** | **98.86 dias** | **100%** |

### Tempo desde Solved até Atribuição do Commander

| Métrica | Valor |
|---------|-------|
| **Tempo Médio** | **28.52 dias** |
| **Mediana** | 28.17 dias |
| **Mínimo** | 0 dias (imediato) |
| **Máximo** | 57.06 dias |
| **Issues sem Commander** | 4 (22%) |

---

## 📊 Comparação: Tempo em "Solved" vs. Tempo até Atribuir Commander

```
Estado "Solved" (média):           15.80 dias ████
Tempo até atribuir Commander:      28.52 dias ████████
                                              ↑
                                      Desalinhamento!
```

⚠️ **Problema Identificado:** O tempo médio para atribuir um Retrospective Commander (28.52 dias) é **quase o dobro** do tempo que os issues ficam em "Solved" (15.80 dias).

Isto sugere que:
1. O Commander não é atribuído logo quando o issue entra em "Solved"
2. Há um atraso significativo na atribuição
3. A transição para "Retrospective In Progress" pode estar a acontecer **antes** da atribuição do Commander

---

## 🔴 Bottlenecks Identificados

### 1. Retrospective In Progress (CRÍTICO)
- **Tempo Médio:** 63.66 dias
- **% do Total:** 69%
- **Problema:** Este estado consome a maior parte do processo
- **7 issues** ultrapassaram 80 dias neste estado

### 2. Atribuição do Retrospective Commander
- **Tempo Médio:** 28.52 dias
- **Problema:** Demora quase 1 mês a atribuir
- **4 issues** (22%) nunca tiveram commander atribuído

### 3. Retrospective Completed
- **Alguns issues muito longos:**
  - RDINC-63691: 65.09 dias
  - RDINC-63743: 63.12 dias
  - RDINC-61732: 49.02 dias

---

## 📈 Top 5 Issues Mais Demorados (Total)

| Issue | Total | Solved | Retro In Progress | Retro Completed | Tempo até Commander |
|-------|-------|--------|-------------------|-----------------|---------------------|
| RDINC-61437 | 134.79 | 44.77 | 83.22 | 6.80 | Não atribuído |
| RDINC-61732 | 132.86 | 8.80 | 75.04 | 49.02 | 11.83 dias |
| RDINC-61911 | 130.97 | 40.95 | 83.22 | 6.80 | Não atribuído |
| RDINC-62612 | 125.58 | 35.56 | 83.22 | 6.80 | Não atribuído |
| RDINC-63322 | 120.03 | 30.24 | 83.95 | 5.84 | **57.06 dias** |

---

## ⚡ Top 5 Issues Mais Rápidos (Total)

| Issue | Total | Tempo até Commander | Observação |
|-------|-------|---------------------|------------|
| RDINC-64612 | 0.01 | Não atribuído | Issue de teste |
| RDINC-72566 | 34.99 | 13.10 dias | ✅ |
| RDINC-65439 | 61.40 | 34.17 dias | |
| RDINC-65898 | 62.37 | 28.17 dias | |
| RDINC-67391 | 65.96 | 34.61 dias | |

---

## 🎯 Issues com Atribuição Imediata de Commander

| Issue | Tempo até Commander | Commander |
|-------|---------------------|-----------|
| RDINC-64639 | 0 dias | pedro.saraiva@outsystems.com |
| RDINC-63691 | 0 dias | nuno.almeida.silva@outsystems.com |

Estes 2 issues tiveram o commander atribuído **imediatamente** quando entraram em Solved.

---

## 🔍 Issues Sem Commander Atribuído (4)

1. **RDINC-61437** - tenant-provision-stuck (134.79 dias total)
2. **RDINC-61911** - Tenant provisioning stuck osall (130.97 dias total)
3. **RDINC-62612** - osall-tenant-provision-stuck (125.58 dias total)
4. **RDINC-64612** - [TEST - Please Ignore] (0.01 dias)

⚠️ **3 dos 4 issues** sem commander são relacionados com "tenant-provision-stuck" e estão entre os mais demorados.

---

## 💡 Recomendações

### 1. Reduzir Tempo em "Retrospective In Progress" (PRIORITÁRIO)
- **Atual:** 63.66 dias (69% do processo)
- **Objetivo Sugerido:** < 30 dias
- **Ações:**
  - Investigar porque demora tanto
  - Identificar bloqueios comuns
  - Criar SLA para este estado

### 2. Agilizar Atribuição do Retrospective Commander
- **Atual:** 28.52 dias em média
- **Objetivo Sugerido:** < 7 dias
- **Ações:**
  - Atribuir commander logo quando move para Solved
  - Automatizar atribuição quando possível
  - Criar rotação/pool de commanders

### 3. Garantir Todos os Issues Têm Commander
- **Atual:** 22% sem commander
- **Ações:**
  - Tornar campo obrigatório
  - Criar alertas para issues sem commander > 7 dias

### 4. Reduzir Variação no Processo
- **Atual:** De 0 dias até 134 dias
- **Ações:**
  - Standardizar processo
  - Criar templates
  - Definir timelines claros

---

## 📁 Ficheiros Gerados

1. **Métricas por Estado:**
   - `retrospectives/data/retrospective-metrics-system-wide-20260311-114536.csv`

2. **Tempo até Commander:**
   - `retrospectives/data/time-to-commander-assignment-20260311-115717.csv`

3. **Documentação:**
   - `retrospectives/docs/SYSTEM-WIDE-IMPACT-SUMMARY.md`
   - `retrospectives/docs/FINAL-ANALYSIS-SUMMARY.md` (este ficheiro)

---

**Análise realizada por:** Claude Code
**Scripts utilizados:** PowerShell + Jira REST API
**Credenciais:** Armazenadas de forma segura em `.credentials/`
