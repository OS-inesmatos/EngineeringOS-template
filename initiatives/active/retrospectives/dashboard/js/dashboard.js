// Load assessment data
let assessmentsData = null;
let filteredAssessments = null;

async function loadData() {
  try {
    const response = await fetch('data/assessments.json');
    assessmentsData = await response.json();
    filteredAssessments = assessmentsData.assessments;
    renderDashboard();
    setupFilters();
  } catch (error) {
    console.error('Error loading data:', error);
  }
}

function renderDashboard() {
  renderStats();
  renderAssessmentCards();
}

function setupFilters() {
  // Populate team filter with unique teams
  const teams = new Set();
  assessmentsData.assessments.forEach(a => {
    a.teams.forEach(team => teams.add(team));
  });

  const teamFilter = document.getElementById('team-filter');
  Array.from(teams).sort().forEach(team => {
    const option = document.createElement('option');
    option.value = team;
    option.textContent = team;
    teamFilter.appendChild(option);
  });

  // Setup event listeners
  document.getElementById('search-input').addEventListener('input', applyFilters);
  document.getElementById('severity-filter').addEventListener('change', applyFilters);
  document.getElementById('status-filter').addEventListener('change', applyFilters);
  document.getElementById('team-filter').addEventListener('change', applyFilters);
}

function applyFilters() {
  const searchTerm = document.getElementById('search-input').value.toUpperCase();
  const severityFilter = document.getElementById('severity-filter').value;
  const statusFilter = document.getElementById('status-filter').value;
  const teamFilter = document.getElementById('team-filter').value;

  filteredAssessments = assessmentsData.assessments.filter(assessment => {
    // Search by incident ID
    const matchesSearch = !searchTerm || assessment.id.toUpperCase().includes(searchTerm);

    // Filter by severity
    const matchesSeverity = !severityFilter || assessment.severity === severityFilter;

    // Filter by status
    const matchesStatus = !statusFilter || assessment.status === statusFilter;

    // Filter by team
    const matchesTeam = !teamFilter || assessment.teams.includes(teamFilter);

    return matchesSearch && matchesSeverity && matchesStatus && matchesTeam;
  });

  // Show/hide results info
  const isFiltered = searchTerm || severityFilter || statusFilter || teamFilter;
  const resultsInfo = document.getElementById('results-info');
  const resultsCount = document.getElementById('results-count');

  if (isFiltered) {
    resultsInfo.style.display = 'flex';
    resultsCount.textContent = `Showing ${filteredAssessments.length} of ${assessmentsData.assessments.length} retrospectives`;
  } else {
    resultsInfo.style.display = 'none';
  }

  renderDashboard();
}

function clearFilters() {
  document.getElementById('search-input').value = '';
  document.getElementById('severity-filter').value = '';
  document.getElementById('status-filter').value = '';
  document.getElementById('team-filter').value = '';
  filteredAssessments = assessmentsData.assessments;
  renderDashboard();
}

function renderStats() {
  const assessments = filteredAssessments;

  if (assessments.length === 0) {
    document.getElementById('total-assessments').textContent = '0';
    document.getElementById('avg-score').textContent = '-';
    document.getElementById('ready-count').textContent = '0';
    document.getElementById('needs-work-count').textContent = '0';
    return;
  }

  const avgScore = Math.round(
    assessments.reduce((sum, a) => sum + a.overallScore, 0) / assessments.length
  );

  const readyCount = assessments.filter(a => a.status === 'ready-for-approval').length;
  const needsWorkCount = assessments.filter(a => a.overallScore < 70).length;

  document.getElementById('total-assessments').textContent = assessments.length;
  document.getElementById('avg-score').textContent = avgScore;
  document.getElementById('ready-count').textContent = readyCount;
  document.getElementById('needs-work-count').textContent = needsWorkCount;
}

function renderAssessmentCards() {
  const container = document.getElementById('assessments-container');
  const assessments = filteredAssessments;

  if (assessments.length === 0) {
    container.innerHTML = `
      <div style="text-align: center; padding: 3rem; color: var(--gray-600);">
        <p style="font-size: 1.125rem; margin-bottom: 0.5rem;">No retrospectives found</p>
        <p style="font-size: 0.875rem;">Try adjusting your search or filters</p>
      </div>
    `;
    return;
  }

  container.innerHTML = assessments.map(assessment => `
    <div class="assessment-card" onclick="window.location.href='detail.html?id=${assessment.id}'">
      <div class="card-header">
        <div class="card-title-section">
          <div class="incident-id">${assessment.id}</div>
          <h3 class="incident-title">${assessment.title}</h3>
          <div class="card-meta">
            <span class="meta-item">
              <span>📅</span>
              <span>${formatDate(assessment.incidentDate)}</span>
            </span>
            <span class="meta-item">
              <span>👥</span>
              <span>${assessment.teams.join(', ')}</span>
            </span>
            <span class="meta-item">
              <span>⏱️</span>
              <span>MTTR: ${assessment.mttr}h</span>
            </span>
            <span class="severity-badge ${assessment.severity.toLowerCase()}">${assessment.severity}</span>
            <span class="status-badge ${getStatusClass(assessment.status)}">${formatStatus(assessment.status)}</span>
          </div>
        </div>
        <div class="score-badge ${getScoreClass(assessment.overallScore)}">
          ${assessment.overallScore}
        </div>
      </div>

      <div class="pillar-scores">
        ${renderPillarScore('🕵️', 'Detection', assessment.pillarScores.detection)}
        ${renderPillarScore('📣', 'Response', assessment.pillarScores.response)}
        ${renderPillarScore('🔍', 'Root Cause', assessment.pillarScores.troubleshooting)}
        ${renderPillarScore('🩹', 'Recovery', assessment.pillarScores.recovery)}
        ${renderPillarScore('🧠', 'Prevention', assessment.pillarScores.prevention)}
        ${renderPillarScore('✅', 'Compliance', assessment.pillarScores.compliance)}
      </div>

      ${assessment.topGaps.length > 0 ? `
        <div class="gaps-section">
          <div class="section-title">Top Gaps</div>
          <div class="gap-list">
            ${assessment.topGaps.slice(0, 3).map(gap => `
              <div class="gap-item">
                <span class="gap-priority ${gap.priority}"></span>
                <span>${gap.question}</span>
              </div>
            `).join('')}
          </div>
        </div>
      ` : ''}
    </div>
  `).join('');
}

function renderPillarScore(emoji, name, score) {
  return `
    <div class="pillar-score">
      <div class="pillar-name">${emoji} ${name}</div>
      <div class="pillar-value" style="color: ${getPillarColor(score)}">${score}</div>
      <div class="pillar-bar">
        <div class="pillar-bar-fill" style="width: ${score}%; background: ${getPillarColor(score)}"></div>
      </div>
    </div>
  `;
}

function getPillarColor(score) {
  if (score >= 70) return '#10b981';
  if (score >= 40) return '#f59e0b';
  return '#ef4444';
}

function getScoreClass(score) {
  if (score >= 85) return 'excellent';
  if (score >= 70) return 'good';
  if (score >= 40) return 'needs-work';
  return 'poor';
}

function getStatusClass(status) {
  if (status === 'ready-for-approval') return 'ready';
  if (status === 'needs-work') return 'needs-work';
  return 'in-progress';
}

function formatStatus(status) {
  return status.split('-').map(word =>
    word.charAt(0).toUpperCase() + word.slice(1)
  ).join(' ');
}

function formatDate(dateString) {
  const date = new Date(dateString);
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  });
}

// Initialize
document.addEventListener('DOMContentLoaded', loadData);
