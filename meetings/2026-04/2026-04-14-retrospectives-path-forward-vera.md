# Retrospectives Path Forward — Follow-up com Vera

**Date:** 2026-04-14 (após meeting com Nuno)  
**Attendees:** Inês Matos, Vera Branco  
**Context:** Definir caminho a seguir após discussão do framework de retrospetivas com Nuno

---

## Contexto

**Meeting anterior (manhã):** Discussão com Vera + Nuno sobre framework de 6 pilares + sistema de semáforos.

**Esta meeting (tarde):** Vera e Inês discutem **opções de implementação** e decidem caminho a seguir.

---

## Opções Discutidas

### Opção 1: Auditar Documentos Existentes ❌
**Descrição:** Pegar em documentos de retrospetiva já existentes e fazer audit/scoring a posteriori.

**Veredito:** **Descartada** — não proporciona controlo adequado sobre o processo.

**Problema:** Avaliação retroativa não melhora a qualidade da coleta de informação durante o incidente.

---

### Opção 2: Framework para Guiar Discussão ✅ (ESCOLHIDA)
**Descrição:** Criar **documento pré-preparado** antes da sessão de RCA que:
- Usa múltiplas fontes de informação (trabalho do Parreira/Nuno)
- Identifica **pontos em aberto** por pilar
- Define **pontos recomendados para discussão**
- Indica **quais equipas devem participar**

**Objetivo:** Tornar sessões de RCA mais objetivas e estruturadas.

**Vantagens:**
- Guia a retrospetiva (não apenas documenta)
- Identifica gaps antes da sessão
- Permite preparação focada
- Evita duplicação de trabalho (documento de scoring = documento final de RCA)

---

## Abordagem Escolhida: "Máquina de Melhoria"

### Conceito
Framework serve como **"máquina de melhoria contínua"** que:
1. Prepara documento pré-retrospetiva (fontes automáticas + skill de Parreira)
2. Identifica pontos em aberto por pilar
3. Guia sessão de RCA com perguntas objetivas
4. Coleta dados durante retrospetiva
5. Identifica padrões recorrentes
6. Alimenta governança com dados

**Analogia:** Não é só documentar o que aconteceu — é criar um sistema que aprende e melhora.

---

## Componentes do Sistema

### 1. Documento Pré-Preparado
**Input:**
- Fontes automáticas (RDINC timeline, Rootly, logs, métricas)
- Skill de Parreira (coleta multi-source)
- Contexto histórico (incidentes similares, retrospetivas anteriores)

**Output:**
- Resumo do incidente
- Factos conhecidos por pilar (Deteção, Resposta, Recuperação, etc.)
- **Pontos em aberto** (red flags: perguntas sem resposta)
- Recomendações para discussão
- Sugestão de participantes (based on ownership, impacted teams)

**Formato:** Documento estruturado, pronto para guiar sessão de RCA.

---

### 2. Framework de Perguntas Objetivas
**Objetivo:** Evitar subjetividade nos scores.

**Estrutura:** Matriz de perguntas por pilar

| Pilar | Pergunta | Tipo | Evidência Esperada |
|-------|----------|------|-------------------|
| **Deteção** | Foi o incidente detectado por monitoring ou por customer report? | Objetivo | Log de alerta OU ticket de suporte |
| **Deteção** | Quanto tempo entre início do problema e primeira notificação? | Métrica | Timestamp (calculável) |
| **Resposta** | Equipa correta foi notificada imediatamente? | Objetivo | Timeline de escalations |
| **Recuperação** | Workaround foi disponibilizado aos clientes afetados? | Sim/Não | Comunicação ou action item |
| **Aprendizado** | Action items foram definidos e assignados? | Sim/Não | Lista de action items com owners |
| **Processo** | Processo de Incident Response foi seguido? | Objetivo | Checklist vs timeline real |

**Resultado:** Score objetivo (🟢 🟡 🔴) baseado em evidências, não em opinião.

---

### 3. Identificação de Recorrências
**Mecanismo:** Quando novo incidente é criado:
1. Sistema verifica se há incidentes similares (root cause, componente, Value Stream)
2. Se houver retrospetiva anterior:
   - Mostra action items definidos
   - Verifica se foram executados
   - **Red flag** se action items não foram executados e problema recorreu
3. Documento pré-preparado inclui secção "Recorrência Detectada"

**Objetivo:** Forçar accountability — não permitir que recorrências passem despercebidas.

---

### 4. Monitorização de Padrões
**Nível 1: Incidente individual** → Retrospetiva → Action items

**Nível 2: Cluster de incidentes** → Padrões identificados → Systemic problems (M3.4)

**Exemplos de padrões:**
- Mesmo root cause em 3+ incidentes (60 dias)
- Mesmo componente falha repetidamente
- Mesmo Value Stream tem 5+ incidentes (systemic issue)
- Mesmo pilar consistentemente "vermelho" (processo gap)

**Ação:** Quando padrão detectado → escala para Problem Management (M3.4 scope).

---

### 5. Governança Baseada em Dados
**Dashboard de Retrospetivas (alimenta M3.1):**

**KPIs por Pilar:**
- % incidentes com deteção automática (vs customer report)
- Tempo médio de resposta (primeiro alerta → assignee notificado)
- % retrospetivas com action items definidos
- % action items executados (follow-up)
- Recurrence rate (mesmo root cause em 90 dias)

**Dashboard de Padrões:**
- Top 3 componentes com mais incidentes
- Top 3 root causes recorrentes
- Value Streams com mais systemic issues
- Pilares consistentemente "vermelhos" (process gaps)

**Uso:** Ops Review, líderes de engenharia, Process Engineering (governança).

---

## Integração com Trabalho do Parreira (Nuno)

**Skill de Nuno:** Gera documento de retrospetiva automaticamente usando múltiplas fontes.

**Integração proposta:**
1. **Skill de Nuno = Input para documento pré-preparado**
   - Coleta factos de múltiplas fontes (Rootly, RDINC, logs, métricas)
   - Popula secções do documento por pilar

2. **Framework de perguntas = Estrutura que guia skill**
   - Skill sabe quais perguntas responder
   - Identifica automaticamente pontos em aberto (perguntas sem resposta)

3. **Output combinado:**
   - Documento pré-preparado com factos (skill de Nuno)
   - + Framework de perguntas objetivas (nosso trabalho)
   - + Contexto histórico/recorrência (nosso trabalho)
   - = Documento completo e acionável para sessão de RCA

**Timeline:** Vera vai partilhar e alinhar plano com Parreira antes da sua saída.

---

## Tornar Critérios Objetivos (Key Challenge)

**Problema identificado:** Scoring subjetivo não funciona.

**Solução:** Perguntas baseadas em **evidência concreta**.

### Maus Exemplos (Subjetivo)
❌ "A comunicação foi eficaz?" → Resposta: "Sim/Mais ou menos/Não" (opinião)  
❌ "A resposta foi rápida?" → Resposta: "Sim" (mas o que é rápido?)

### Bons Exemplos (Objetivo)
✅ "Customers afetados foram notificados?" → Resposta: "Sim" + evidência (email, portal status page)  
✅ "Tempo entre alerta e primeira resposta?" → Resposta: "15 minutos" (métrica, calculável)  
✅ "Runbook foi seguido?" → Resposta: "Não, passo X foi saltado" (checklist vs timeline)

**Next Step:** Vera e Inês vão trabalhar para tornar critérios de avaliação objetivos.

---

## Roadmap de Implementação

### Fase 1: MVP (Próximos 15 dias) — "Máquina de Melhoria" Básica
**Deliverables:**
1. **Framework de perguntas objetivas** (matriz: pilar → perguntas → evidências)
2. **Template de documento pré-preparado** (estrutura: factos + pontos em aberto + recomendações)
3. **Pilot:** Testar com 2-3 retrospetivas existentes (post-mortems de incidentes recentes)
4. **Alinhamento com Parreira:** Validar integração da skill dele com framework

**Responsáveis:** Vera + Inês

---

### Fase 2: Detecção de Recorrência (Q2, alinhado com M3.4)
**Deliverables:**
1. **Mecanismo de correlação:** Sistema que identifica incidentes similares
2. **Red flags:** Quando recorrência detectada + action items não executados
3. **Pilot:** Usar teus 19 incidentes sem retrospetiva (8 system-wide) para testar clustering

**Responsáveis:** Inês (lead) + Nuno (skill para correlação)

---

### Fase 3: Governança e Dashboards (Q2, integração M3.1)
**Deliverables:**
1. **Dashboard de retrospetivas:** KPIs por pilar (lead time, quality, action items follow-up)
2. **Dashboard de padrões:** Top recorrências, systemic issues por Value Stream
3. **Governance model:** Quem revê KPIs, quando, escalations

**Responsáveis:** Vera + Inês (alinhado com M3.1 Failure Management Governance)

---

### Fase 4: "Máquina de Melhoria" Completa (Q3)
**Deliverables:**
1. Sistema automatizado: incidente fecha → skill gera documento pré-preparado → retrospetiva agendada → documento final → KPIs atualizados → padrões detectados
2. Integração full-cycle: Incident → Retrospective → Problem (M3.4)
3. Feedback loop: Patterns detectados → Process improvements → Governance decisions

---

## Decisões e Next Steps

### Vera
- [x] Escrever e montar opções discutidas (esta meeting fez isso)
- [ ] Compartilhar e alinhar plano com Parreira antes da sua saída
- [ ] Tirar foto (registar) estado atual do documento/plano para referência futura
- [ ] Trabalhar em tornar critérios de avaliação objetivos (com Inês)

### Inês
- [x] Processar notas da reunião (este documento)
- [ ] Revisar documento proposto por Vera para validar se o caminho faz sentido
- [ ] Desenvolver matriz de perguntas objetivas por pilar (próximos 15 dias)
- [ ] Desenvolver forma de identificar e monitorar recorrências
- [ ] Definir e documentar questões de processo e qualidade a validar nas retrospetivas

### Vera + Inês (conjunto)
- [ ] Estruturar disponibilização de relatórios e pontos em aberto para as equipes
- [ ] Trabalhar em MVP (framework de perguntas + template de documento pré-preparado)
- [ ] Pilotar com 2-3 retrospetivas existentes
- [ ] Definir governance model (quem, quando, escalations)

---

## Conexões com Meu Trabalho

### Priority 3: Retrospectives Process Excellence ✅✅
**Alinhamento total:** Este é o novo modelo de retrospetivas.

**Meu contributo:**
- Framework de perguntas objetivas (matriz)
- Template de documento pré-preparado
- Mecanismo de detecção de recorrência
- Pilotar com meus 19 incidentes sem retrospetiva

---

### M3.4 (Problem Management, Q2-Q3) ✅✅
**Foundation:** Detecção de padrões e systemic problems.

**Meu contributo:**
- Clustering de retrospetivas por padrão (8 system-wide incidents)
- Elevação de RPM individual → Systemic Problem
- Integração Retrospective → Problem Management

---

### M3.1 (Failure Management Governance) ✅
**Dashboard de KPIs:** Retrospetivas alimentam M3.1 dashboards.

**Meu contributo:**
- KPIs por pilar (deteção, resposta, recovery, learning)
- Governance model (review cadence, escalations)
- Quality metrics (% action items executados, recurrence rate)

---

### M3.3 (Triage Models & OLAs) 🤔
**Possível ligação:** Framework pode ajudar a identificar quando Support Case vs Incident vs Problem Record.

**A explorar:** Se padrão de deteção consistentemente "vermelho" (customer report vs monitoring) → oportunidade para melhorar triage.

---

## Perguntas em Aberto

1. **Tooling:** Onde vive o documento pré-preparado?
   - Coda? Confluence? Sequil?
   - Skill de Parreira gera onde?

2. **Ownership:** Quem é responsável por preparar o documento?
   - Retrospective Commander?
   - Process Engineering (automatizado)?
   - Skill de Parreira (automatizado)?

3. **Timeline:** Quando documento é gerado?
   - Imediatamente quando incidente fecha?
   - X dias antes da sessão de RCA?
   - On-demand (Commander pede)?

4. **Integração com Rootly:** Como puxar dados?
   - API? Export? Manual?

5. **Governança:** Quem revê os dashboards de padrões?
   - Ops Review?
   - Eng Managers?
   - Process Engineering?
   - Cadência? (semanal, mensal?)

---

## Insights e Quotes

### Sobre Abordagem
> "Primeiro precisamos entender a situação atual antes de implementar novos processos. Vamos decidir por uma abordagem específica e depois testá-la para ver se funciona." — Vera

### Sobre Framework como Máquina de Melhoria
> "Este framework ajudaria a identificar padrões e questões em falha nos diferentes pilares, permitindo um melhor ciclo de melhoria contínua." — Vera

### Sobre Documento Pré-Preparado
> "O documento inclui pontos recomendados para discussão e define quais equipes devem participar das sessões, com o objetivo de melhor monitorizar e guiar as retrospectivas futuras." — Vera

### Sobre Recorrências
> "Desenvolver uma matriz de perguntas para guiar as retrospetivas e monitorar padrões de recorrência, com o objetivo de melhorar a governança e a consciência sobre processos." — Vera + Inês

---

## Comparação: Morning Meeting vs Afternoon Meeting

| Aspecto | Morning (com Nuno) | Afternoon (com Vera) |
|---------|-------------------|---------------------|
| **Foco** | Problemas (action items não executados, recorrência) | Soluções (como implementar framework) |
| **Outcome** | 6 pilares + semáforos (o quê) | Documento pré-preparado + máquina de melhoria (como) |
| **Stakeholder** | Nuno (technical, skill builder) | Vera (process, governance) |
| **Timeline** | 15 dias (MVP) | Faseado (MVP → Recorrência → Governance → Full system) |
| **Integração** | Skill de Nuno como input | Framework como estrutura, skill como engine |

**Síntese:** Morning = **O QUÊ** fazer (framework, pilares, problemas). Afternoon = **COMO** fazer (documento pré-preparado, máquina de melhoria, governança).

---

## Reflexão

**O que correu bem:**
- Clareza na escolha da abordagem (Opção 2: framework para guiar)
- Conceito de "máquina de melhoria" é forte — não é só doc, é sistema de aprendizagem
- Alinhamento total com Priority 3, M3.4, M3.1
- Faseamento realista (MVP → Recorrência → Governance → Full)

**Desafios identificados:**
- Tornar perguntas objetivas (não subjetivas) — requer trabalho cuidadoso
- Integração com skill de Parreira antes da sua saída — timeline apertada
- Tooling (onde vive o documento?) ainda por definir
- Governança (quem revê dashboards?) precisa de alignment com leadership

**Oportunidade:**
- Isto é o novo modelo de retrospetivas (Priority 3) ✅
- Foundation para M3.4 (systemic problems via pattern detection) ✅
- Feeds M3.1 dashboards (KPIs, governance) ✅
- Potencial para M3.3 (triage via deteção patterns) 🤔

**Próximo passo crítico:** Draft de framework de perguntas objetivas (matriz) nos próximos dias.

---

**Tags:** #retrospectives #framework #governance #m3.4 #priority3 #vera #nuno-parreira #machine-of-improvement
