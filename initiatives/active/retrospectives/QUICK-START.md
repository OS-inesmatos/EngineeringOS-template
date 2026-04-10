# Retrospective Metrics - Quick Start Guide

## ✅ Setup Completo!

As credenciais já foram configuradas e o script foi testado com sucesso no RDINC-67391.

## 🚀 Como Usar

### Analisar um único issue

```powershell
cd Documents\koda+claude\retrospectives\scripts
.\Get-RetroMetrics.ps1 -IssueKeys "RDINC-67391"
```

### Analisar múltiplos issues

```powershell
.\Get-RetroMetrics.ps1 -IssueKeys "RDINC-67391","RDINC-67392","RDINC-67393"
```

### Analisar issues de um ficheiro

1. Crie um ficheiro `issues.txt` com um issue por linha:
```
RDINC-67391
RDINC-67392
RDINC-67393
```

2. Execute:
```powershell
$issues = Get-Content issues.txt
.\Get-RetroMetrics.ps1 -IssueKeys $issues
```

## 📊 O que é medido

Para incidents com **"System-wide impact? = Yes"**, o script mede:

1. **Solved** - Tempo desde que o incident foi marcado como Solved até ser atribuído ao retrospective commander
2. **Retrospective In Progress** - Tempo desde a atribuição até a retrospective estar completa
3. **Retrospective Completed** - Tempo desde a conclusão da retro até todas as improvement actions estarem fechadas

## 📁 Onde encontrar os resultados

Os ficheiros CSV são guardados em:
```
Documents\koda+claude\retrospectives\data\retrospective-metrics-YYYYMMDD-HHMMSS.csv
```

## 📋 Exemplo de Resultado (RDINC-67391)

| Status | Entry Date | Exit Date | Dias | Horas |
|--------|------------|-----------|------|-------|
| Solved | 2025-12-30 17:44:02 | 2026-02-03 08:16:44 | 34.61 | 830.55 |
| Retrospective In Progress | 2026-02-03 08:16:44 | 2026-03-06 16:12:08 | 31.33 | 751.92 |
| Retrospective Completed | 2026-03-06 16:12:08 | 2026-03-06 16:38:30 | 0.02 | 0.44 |

## 💡 Próximos Passos

1. Obter lista de todos os RDINC issues com "System-wide impact? = Yes"
2. Processar em batch
3. Analisar métricas agregadas
4. Identificar bottlenecks no processo

## 🔧 Scripts Disponíveis

- `Get-RetroMetrics.ps1` - Script principal ✅
- `Setup-JiraCredentials.ps1` - Configuração de credenciais ✅
- `Test-JiraAPI.ps1` - Diagnóstico de conexão
- `Test-JiraConnection.ps1` - Teste simples

## 📞 Troubleshooting

**Erro: Credentials not found**
- Execute: `.\Setup-JiraCredentials.ps1`

**Erro: Authentication failed**
- Regenere o API token em: https://id.atlassian.com/manage-profile/security/api-tokens
- Execute novamente: `.\Setup-JiraCredentials.ps1`
