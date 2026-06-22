#!/bin/bash
# Obtiene el reporte completo de SonarQube y lo guarda en .tmp/
# Requiere: SONAR_HOST_URL, SONAR_TOKEN, SONAR_PROJECT_KEY en .env

set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

: "${SONAR_HOST_URL:?Variable SONAR_HOST_URL no definida}"
: "${SONAR_TOKEN:?Variable SONAR_TOKEN no definida}"
: "${SONAR_PROJECT_KEY:?Variable SONAR_PROJECT_KEY no definida}"

mkdir -p .tmp

echo "Obteniendo reporte de SonarQube para: $SONAR_PROJECT_KEY"
echo "------------------------------------------------------------"

# 1. Estado del quality gate
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/qualitygates/project_status?projectKey=$SONAR_PROJECT_KEY" \
  -o .tmp/sonar-quality-gate.json
echo "✓ Quality gate        → .tmp/sonar-quality-gate.json"

# 2. Bugs y vulnerabilidades CRITICAL/MAJOR activos
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/issues/search?componentKeys=$SONAR_PROJECT_KEY&resolved=false&types=BUG,VULNERABILITY&severities=CRITICAL,MAJOR&ps=100" \
  -o .tmp/sonar-issues.json
echo "✓ Bugs/vulnerabilidades → .tmp/sonar-issues.json"

# 3. Security hotspots pendientes de revisión
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/hotspots/search?projectKey=$SONAR_PROJECT_KEY&status=TO_REVIEW&ps=100" \
  -o .tmp/sonar-hotspots.json
echo "✓ Security hotspots   → .tmp/sonar-hotspots.json"

# 4. Code smells CRITICAL/MAJOR
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/issues/search?componentKeys=$SONAR_PROJECT_KEY&resolved=false&types=CODE_SMELL&severities=CRITICAL,MAJOR&ps=100" \
  -o .tmp/sonar-code-smells.json
echo "✓ Code smells         → .tmp/sonar-code-smells.json"

# 5. Issues introducidos en código nuevo (desde último análisis)
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/issues/search?componentKeys=$SONAR_PROJECT_KEY&resolved=false&sinceLeakPeriod=true&ps=100" \
  -o .tmp/sonar-new-code.json
echo "✓ Código nuevo        → .tmp/sonar-new-code.json"

# 6. Métricas generales
curl -sf -u "$SONAR_TOKEN:" \
  "$SONAR_HOST_URL/api/measures/component?component=$SONAR_PROJECT_KEY&metricKeys=coverage,bugs,vulnerabilities,code_smells,security_hotspots,duplicated_lines_density,ncloc" \
  -o .tmp/sonar-metrics.json
echo "✓ Métricas            → .tmp/sonar-metrics.json"

# Resumen en consola
echo ""
echo "============================ RESUMEN ============================"

GATE=$(node -e "
  const d = require('./.tmp/sonar-quality-gate.json');
  console.log(d.projectStatus?.status ?? 'UNKNOWN');
" 2>/dev/null || echo "N/A")

ISSUES=$(node -e "
  const d = require('./.tmp/sonar-issues.json');
  console.log(d.total ?? 0);
" 2>/dev/null || echo "?")

HOTSPOTS=$(node -e "
  const d = require('./.tmp/sonar-hotspots.json');
  console.log(d.paging?.total ?? 0);
" 2>/dev/null || echo "?")

SMELLS=$(node -e "
  const d = require('./.tmp/sonar-code-smells.json');
  console.log(d.total ?? 0);
" 2>/dev/null || echo "?")

NEW=$(node -e "
  const d = require('./.tmp/sonar-new-code.json');
  console.log(d.total ?? 0);
" 2>/dev/null || echo "?")

echo "  Quality gate:          $GATE"
echo "  Bugs/vulns activos:    $ISSUES"
echo "  Hotspots por revisar:  $HOTSPOTS"
echo "  Code smells (CR/MA):   $SMELLS"
echo "  Issues en código nuevo: $NEW"
echo "================================================================="
echo ""
echo "Revisar .tmp/ y agregar manualmente las tareas relevantes al board."
