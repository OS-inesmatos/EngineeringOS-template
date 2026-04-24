// Metrics page logic
let assessmentsData = null;

async function loadData() {
  try {
    const response = await fetch('data/assessments.json');
    assessmentsData = await response.json();
    renderMetrics();
  } catch (error) {
    console.error('Error loading data:', error);
  }
}

function renderMetrics() {
  renderScoreDistribution();
  renderPillarAverages();
  renderCommonGaps();
  renderScoreOverTime();
}

function renderScoreDistribution() {
  const ctx = document.getElementById('scoreDistributionChart').getContext('2d');
  const scores = assessmentsData.assessments.map(a => a.overallScore);

  const distribution = {
    '85-100': scores.filter(s => s >= 85).length,
    '70-84': scores.filter(s => s >= 70 && s < 85).length,
    '40-69': scores.filter(s => s >= 40 && s < 70).length,
    '0-39': scores.filter(s => s < 40).length
  };

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['Excellent (85-100)', 'Good (70-84)', 'Needs Work (40-69)', 'Poor (0-39)'],
      datasets: [{
        label: 'Number of Retrospectives',
        data: Object.values(distribution),
        backgroundColor: [
          '#10b981',
          '#3b82f6',
          '#f59e0b',
          '#ef4444'
        ],
        borderWidth: 0
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: true,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  });
}

function renderPillarAverages() {
  const ctx = document.getElementById('pillarAveragesChart').getContext('2d');
  const assessments = assessmentsData.assessments;

  const avgScores = {
    detection: Math.round(assessments.reduce((sum, a) => sum + a.pillarScores.detection, 0) / assessments.length),
    response: Math.round(assessments.reduce((sum, a) => sum + a.pillarScores.response, 0) / assessments.length),
    troubleshooting: Math.round(assessments.reduce((sum, a) => sum + a.pillarScores.troubleshooting, 0) / assessments.length),
    recovery: Math.round(assessments.reduce((sum, a) => sum + a.pillarScores.recovery, 0) / assessments.length),
    prevention: Math.round(assessments.reduce((sum, a) => sum + a.pillarScores.prevention, 0) / assessments.length),
    compliance: Math.round(assessments.reduce((sum, a) => sum + a.pillarScores.compliance, 0) / assessments.length)
  };

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: [
        '🕵️ Detection',
        '📣 Response',
        '🔍 Root Cause',
        '🩹 Recovery',
        '🧠 Prevention',
        '✅ Compliance'
      ],
      datasets: [{
        label: 'Average Score',
        data: Object.values(avgScores),
        backgroundColor: Object.values(avgScores).map(score => {
          if (score >= 70) return '#10b981';
          if (score >= 40) return '#f59e0b';
          return '#ef4444';
        }),
        borderWidth: 0
      }]
    },
    options: {
      indexAxis: 'y',
      responsive: true,
      maintainAspectRatio: true,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        x: {
          beginAtZero: true,
          max: 100
        }
      }
    }
  });
}

function renderCommonGaps() {
  const allGaps = assessmentsData.assessments.flatMap(a => a.topGaps);
  const gapCounts = {};

  allGaps.forEach(gap => {
    const key = gap.question;
    if (!gapCounts[key]) {
      gapCounts[key] = { count: 0, priority: gap.priority, pillar: gap.pillar };
    }
    gapCounts[key].count++;
  });

  const sortedGaps = Object.entries(gapCounts)
    .sort((a, b) => b[1].count - a[1].count)
    .slice(0, 5);

  const container = document.getElementById('common-gaps-list');
  container.innerHTML = sortedGaps.map(([question, data]) => `
    <div class="gap-item">
      <span class="gap-priority ${data.priority}"></span>
      <div style="flex: 1">
        <div style="font-weight: 500; margin-bottom: 0.25rem">${question}</div>
        <div style="font-size: 0.75rem; color: var(--gray-600)">
          ${data.pillar} - Found in ${data.count} retrospective${data.count > 1 ? 's' : ''}
        </div>
      </div>
    </div>
  `).join('');
}

function renderScoreOverTime() {
  const ctx = document.getElementById('scoreOverTimeChart').getContext('2d');
  const assessments = [...assessmentsData.assessments].sort((a, b) =>
    new Date(a.assessmentDate) - new Date(b.assessmentDate)
  );

  new Chart(ctx, {
    type: 'line',
    data: {
      labels: assessments.map(a => formatDate(a.assessmentDate)),
      datasets: [{
        label: 'Overall Score',
        data: assessments.map(a => a.overallScore),
        borderColor: '#2563eb',
        backgroundColor: 'rgba(37, 99, 235, 0.1)',
        tension: 0.3,
        fill: true
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: true,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          max: 100
        }
      }
    }
  });
}

function formatDate(dateString) {
  const date = new Date(dateString);
  return date.toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric'
  });
}

// Initialize
document.addEventListener('DOMContentLoaded', loadData);
