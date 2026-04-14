# Retrospectives Framework Discussion — Vera + Nuno Parreira

**Date:** 2026-04-14  
**Attendees:** Inês Matos, Vera Branco, Nuno Parreira  
**Context:** Discussão sobre framework de avaliação de retrospetivas e possível colaboração com skill de Nuno

---

## Contexto

**Nuno Parreira:** Bom stakeholder para o tema de retrospetivas. Criou uma **skill para gerar documento de retrospetiva automaticamente** quando um incidente é fechado, usando múltiplas fontes.

**Oportunidade:** A skill do Nuno pode complementar o novo processo de retrospetivas (Priority 3, Q1 2026).

---

## Framework Proposto: Avaliação por Pilares

### Sistema de Semáforos
Avaliar incidentes usando sistema de semáforos (🟢 🟡 🔴) baseado em **6 pilares**:

1. **Deteção** — Como detectamos o problema?
2. **Resposta/Mitigação** — Qual foi a resposta inicial?
3. **Recuperação** — Como restauramos o serviço?
4. **Aprendizado** — O que aprendemos?
5. **Processo** — Os processos foram seguidos?
6. **Comunicação** — A comunicação foi eficaz?

**Objetivo:** Criar relatório com semáforo que guie as sessões de retrospetiva.

---

## Problemas Identificados

### 1. **Action Items Não São Executados** 🔴
**Problema central:** RCAs existem, mas action items não têm follow-up.

**Exemplo (Nuno):** 
- Slots configurados não disparam alarmes
- Problema conhecido, RCA feito, mas nenhuma ação tomada
- Alarmes só foram ligados após novo incidente (fine-tuning para evitar falsos positivos)

**Consequência:** Recorrência de incidentes porque problemas identificados não são corrigidos.

---

### 2. **Falta de Governança e Accountability** 🔴
**Nuno:** "Semelhante a vendas com comissão — processos precisam de incentivos claros para implementação efetiva."

**Gap:** 
- Não há tracking sistemático de action items
- Não há escalation quando action items não são executados
- Não há ownership claro (quem é accountable?)

**Necessidade:** Governança estrita para garantir que padrões sejam seguidos.

---

### 3. **Recorrência Não É Detectada** 🔴
**Problema:** Quando um incidente recorre, não há mecanismo automático para:
1. Identificar que já houve RCA anterior
2. Verificar se action items foram executados
3. Escalar se ação não foi tomada

**Proposta:** Correlacionar novos incidentes com incidentes passados (Nuno pode ajudar com skill).

---

### 4. **Documento RCA Traz Pouco Valor** 🟡
**Problema:** Documentos existem mas não são acionáveis.

**Subjectividade:** Nuno expressou preocupação sobre scoring baseado em documentos preparados — preferível ter perguntas concretas e evidências objetivas.

**Debate:** 
- **Avaliar documentos existentes** (post mortem) ou
- **Guiar coleta de informação em tempo real** durante resolução do incidente?

**Decisão:** Começar com documento pós-incidente preliminar, depois aplicar scoring após aprovação do relatório final.

---

## Decisões e Next Steps

### Refinamento do Modelo de Retrospetiva
**Inês + Vera:**
- Refinar modelo para **detectar recorrência de incidentes**
- Garantir **follow-up de action items não executados** em incidentes anteriores
- Integrar perguntas e pilares propostos na estrutura de documentos de retrospetiva

---

### Governança e Accountability
**Vera:** Comunicar aos líderes de engenharia (com João/Rodrigo):
- Reforçar **governança** sobre execução de action items
- Estabelecer **accountability** clara
- Mensagem: prioridade e compliance na realização e acompanhamento de retrospetivas

**Inês + Vera:** Desenvolver mecanismo de governança/observabilidade:
- Monitorar execução de action items
- Sinalizar recorrências ou falta de ação
- Possíveis integrações: Coda, Sequil (ferramentas mencionadas)

---

### Detecção de Recorrência
**Nuno:** Correlacionar novos incidentes com incidentes passados para identificar padrões.

**Inês:** Detectar e sinalizar incidentes recorrentes, especialmente quando:
- Já houve RCA anterior
- Action items não foram executados
- Comunicar às equipas responsáveis para intervenção

---

### Estrutura de Documentos
**Inês:** 
- Atualizar documentos de retrospetiva na ferramenta aprovada (Coda)
- Garantir que todos usem mesma estrutura e fonte de informação
- Partilhar e alinhar com equipas os pilares e perguntas do framework

**Nuno:** 
- Rever placeholders e templates de RCA
- Garantir alinhamento com boas práticas discutidas
- Avaliar integração de dados técnicos capturados pela skill para enriquecer análise

---

### Sistema de Semáforos e Scoring
**Debate:** Perguntas devem ser **objetivas (sim/não)** ou permitir **pesos e complexidade**?

**Decisão:** 
1. Criar documento pós-incidente preliminar (factos)
2. Equipas enriquecem informação
3. Scoring aplicado **após aprovação do relatório final**
4. Usar evidências específicas (não scores subjetivos)

**Objetivo:** Sistema de scoring para identificar **tendências e padrões** em incidentes.

---

### Timeline
**Próximos 15 dias:**
- Desenvolver estratégia
- Implementar semáforo inicial
- Preparar base da discussão
- Testar com post-mortems existentes (Nuno propõe)

---

## Insights e Quotes

### Sobre Governança
> "Semelhante a vendas com comissão — processos precisam de incentivos claros para implementação efetiva." — Nuno

### Sobre Action Items
> "RCAs existem, mas ninguém está a fazer tracking adequado dos action items. O documento traz pouco valor." — Vera

### Sobre Recorrência
> "Tivemos um incidente recorrente que já teve RCA anterior, mas nenhuma ação foi tomada sobre os action items." — Nuno

### Sobre Objetividade
> "Não podemos dar scores sem uma base de factos completa. O scoring deve ocorrer após aprovação do relatório pós-incidente final." — Nuno

---

## Conexões com Meu Trabalho (Q1 2026)

### Priority 3: Retrospectives Process Excellence ✅
- **Alinhamento perfeito:** Este framework é exatamente o que Priority 3 precisa
- **Gap identificado:** 19 incidentes sem Retrospective Commander (teu trabalho atual)
- **Oportunidade:** Usar framework de pilares + skill de Nuno para acelerar criação de retrospetivas

### M3.4 (Problem Management, Q2-Q3) ✅
- **Detecção de recorrência:** Crítico para M3.4 — identificar systemic problems
- **Clustering:** Teus 8 system-wide incidents podem ser pilot para correlação de recorrência
- **Action Items tracking:** Governance mechanism que falta para M3.4

### M3.1 (Failure Management Governance) ✅
- **KPI tracking:** Sistema de semáforos pode alimentar M3.1 dashboards
- **Governança:** Framework de accountability alinha com M3.1 controlling framework

---

## Perguntas em Aberto

1. **Pilares são standard da indústria ou específicos da equipa?**
   - Nuno questionou se são padronizados
   - Foco deve ser na prática, não no documento final

2. **Coda vs Deixtl (tools)?**
   - Discussão sobre transição de ferramentas de documentação
   - Nuno mencionou necessidade de atualizações e aprovações

3. **Quem faz o scoring?**
   - Retrospective Commander?
   - Process Engineering?
   - Automatizado pela skill de Nuno?

4. **Como integrar skill de Nuno com processo atual?**
   - Skill gera documento automaticamente quando incidente fecha
   - Como garantir que documento gerado segue framework de pilares?

---

## Próximos Passos (Meus)

### Esta Semana
- [ ] Rever pilares propostos contra industry standards (Google SRE Book, Incident Review best practices)
- [ ] Mapear perguntas concretas para cada pilar (objetivas, não subjetivas)
- [ ] Identificar gaps no template atual de retrospetiva vs pilares propostos

### Próximos 15 Dias
- [ ] Colaborar com Nuno: alinhar skill dele com framework de pilares
- [ ] Propor mecanismo de detecção de recorrência (usar teu trabalho: 19 incidents, 8 system-wide)
- [ ] Draft de governance model: quem faz o quê, quando, escalations

### Q2 (M3.4 Prep)
- [ ] Usar este framework como foundation para M3.4 Problem Management
- [ ] Pilotar com teus 8 system-wide incidents (clustering, recurrence detection)
- [ ] Integrar com M3.1 dashboards (KPIs: % action items executed, recurrence rate)

---

## Recursos Mencionados

- **Nuno's skill:** Gera documento de retrospetiva automaticamente (múltiplas fontes)
- **Ferramentas:** Coda, Sequil, Deixtl (documentação e observabilidade)
- **Stakeholders:** João/Rodrigo (líderes de engenharia para reforçar governança)

---

## Reflexão

**O que correu bem:**
- Alinhamento entre Vera, Nuno e eu sobre problemas (action items não executados, recorrência)
- Framework de pilares é sólido e acionável
- Nuno é stakeholder forte — tem skin in the game (built a skill, entende o problema)

**Desafios identificados:**
- Governança é o blocker crítico — sem isso, framework não funciona
- Subjectividade vs objetividade no scoring — precisa de clareza
- Tooling (Coda, Deixtl) ainda em discussão

**Oportunidade:**
- Este framework + skill de Nuno + meu trabalho de retrospectives (Priority 3) = foundation para M3.4
- Usar próximos 15 dias para criar MVP (semáforo inicial, teste com post-mortems)

---

**Tags:** #retrospectives #governance #incident-management #m3.4 #priority3 #nuno-parreira
