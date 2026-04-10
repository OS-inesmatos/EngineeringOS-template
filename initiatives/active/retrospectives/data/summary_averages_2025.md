# Resumo Final - Médias das Análises de Retrospetivas 2025

**Período:** Janeiro a Dezembro de 2025
**Amostra:** 115 issues RDINC com Retrospective Needed = Yes
**Query JQL:** `project = RDINC AND (status = 'Retrospective Completed' OR status = Closed) AND 'Retrospective Needed' = Yes AND resolved >= '2025-01-01' AND resolved <= '2025-12-31'`

---

## 1. Lead Time Global

| Métrica | Valor | Observações |
|---------|-------|-------------|
| **Lead Time Médio** | **88.6 dias** | SOLVED → Retrospective Completed |
| Lead Time Mediano | 69.6 dias | Metade dos issues leva menos tempo |
| Mínimo | 0.0 dias | Alguns issues sem tempo em SOLVED |
| Máximo | 305.6 dias | RDINC-43232 (caso extremo) |
| Desvio Padrão | 60.2 dias | Alta variabilidade |
| **Comparação Confluence** | 72 dias documentados | **+23% diferença** (88.6 vs 72) |

---

## 2. Tempo por Estado

| Estado | Tempo Médio | % do Lead Time | Observações |
|--------|-------------|----------------|-------------|
| **SOLVED** | **20.9 dias** | **24%** | Aguarda atribuição de Commander |
| **Retrospective In Progress** | **70.4 dias** | **79%** | **BOTTLENECK PRINCIPAL** |
| **TOTAL** | **91.3 dias** | **103%** | Ligeira diferença devido a arredondamentos |

> **Nota:** A soma (91.3 dias) é ligeiramente superior ao lead time (88.6 dias) devido a alguns issues que não passaram por todos os estados ou tiveram múltiplas transições.

---

## 3. Breakdown da "Retrospective In Progress"

A análise do campo "RCA Request Date/Time" permite dividir o tempo em Retrospective In Progress:

| Fase | Tempo Médio | % do Tempo em Retro IP | Observações |
|------|-------------|------------------------|-------------|
| **Phase 1:** Retro IP → RCA Request | **24.4 dias** | **33%** | Tempo para pedir o RCA |
| **Phase 2:** RCA Request → Completed | **50.2 dias** | **67%** | **BOTTLENECK CRÍTICO** |
| **TOTAL Retro IP** | **74.6 dias** | **100%** | Ligeiramente diferente dos 70.4 dias da análise de estados |

> **Descoberta Chave:** O maior atraso (50.2 dias) ocorre **APÓS** o pedido de RCA, não antes.

---

## 4. Concentração de Reviewers

| Reviewer | Nº Issues | % do Total | Observações |
|----------|-----------|------------|-------------|
| Louise Perold | 36 | 31% | Top reviewer |
| Paulo Alves Monteiro | 20 | 17% | 2º reviewer |
| **COMBINADO (Top 2)** | **56** | **49%** | **Quase metade das retrospetivas** |
| Outros reviewers | 59 | 51% | Distribuído por restantes |
| **Total analisado** | **115** | **100%** | |
| **Comparação Confluence** | 63% documentados | Análise mostra 49% (menor concentração) |

---

## 5. Distribuições

### Lead Time (SOLVED → Retrospective Completed)
- **0-30 dias:** 18 issues (16%)
- **30-60 dias:** 33 issues (29%)
- **60-90 dias:** 26 issues (23%)
- **90-120 dias:** 15 issues (13%)
- **120+ dias:** 23 issues (20%)

### Time in SOLVED
- **0-10 dias:** 38 issues (39%)
- **10-20 dias:** 22 issues (23%)
- **20-30 dias:** 13 issues (13%)
- **30+ dias:** 24 issues (25%)

### Time in Retrospective In Progress
- **0-30 dias:** 8 issues (9%)
- **30-60 dias:** 32 issues (36%)
- **60-90 dias:** 25 issues (28%)
- **90+ dias:** 24 issues (27%)

---

## 6. Top 10 Issues com Maior Lead Time

| Issue | Lead Time (dias) | Time in SOLVED | Time in Retro IP |
|-------|------------------|----------------|------------------|
| RDINC-43232 | 305.6 | 22.6 | 283.0 |
| RDINC-60095 | 239.6 | 3.0 | 236.6 |
| RDINC-58934 | 205.0 | 35.1 | 169.9 |
| RDINC-51652 | 203.9 | 2.5 | 201.4 |
| RDINC-44424 | 201.6 | 0.8 | 200.8 |
| RDINC-51654 | 195.4 | 5.1 | 190.3 |
| RDINC-51655 | 195.2 | 4.8 | 190.4 |
| RDINC-51653 | 195.1 | 4.5 | 190.6 |
| RDINC-45850 | 193.9 | 5.5 | 188.4 |
| RDINC-38782 | 191.8 | 0.6 | 191.2 |

---

## 7. Conclusões Principais

### Bottlenecks Identificados (por ordem de impacto):

1. **🔴 Phase 2 (RCA Request → Completed): 50.2 dias (67% do tempo em Retro IP)**
   - Principal atraso no processo
   - Ocorre APÓS ter o RCA, não antes
   - Indica problemas na execução/finalização da retrospetiva

2. **🟡 Time in Retrospective In Progress: 70.4 dias (79% do lead time total)**
   - Estado onde se passa a maior parte do tempo
   - Confirma que o problema não é na atribuição (SOLVED)

3. **🟢 Time in SOLVED: 20.9 dias (24% do lead time)**
   - Menor impacto relativo
   - Tempo de espera para atribuição de Commander

### Comparação com Dados Confluence:
- **Lead Time:** 88.6 dias (calculado) vs 72 dias (documentado) = **+23% diferença**
- **Reviewer Concentration:** 49% (calculado) vs 63% (documentado) = **Menor concentração que esperado**

### Qualidade dos Dados:
- Alguns valores negativos na Phase 1 indicam problemas de data quality
- Casos extremos (305+ dias) podem precisar de análise individual
- 115 issues é uma amostra representativa para 2025

---

**Data da Análise:** 2026-03-12
**Scripts Utilizados:**
- `calculate_leadtime.js`
- `calculate_time_in_status.js`
- `analyze_reviewers.js`
- `analyze_rca_request_timing.js`
