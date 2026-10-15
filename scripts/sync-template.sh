#!/bin/bash
# Sincroniza la rama template con la parte genérica del framework que vive en main.
# Crea una rama desde template (o reutiliza la indicada si ya existe, local o en
# origin), copia los archivos base y deja todo sin commitear para revisión humana.
# El commit y el merge a template son manuales.
# Lo ejecuta el humano, no el agente (ver decisions/017 y decisions/019).
#
# Uso: scripts/sync-template.sh <rama>
# Ej.: scripts/sync-template.sh proceso/0007-sincronizar-template

set -euo pipefail

SOURCE_BRANCH="main"
TEMPLATE_BRANCH="template"
TARGET_BRANCH="${1:?Uso: scripts/sync-template.sh <rama>}"

# Genéricos: se copian de main como espejo exacto (incluye archivos eliminados)
BASE_PATHS=(
  CLAUDE.md
  README.md
  .gitignore
  .env.example
  scripts
  .claude/skills
  docs/CONSTITUTION.md
  docs/standards
  docs/adapters
  docs/templates
)

# Solo sirven para mantener el framework; no viajan a template
EXCLUDED_PATHS=(
  scripts/sync-template.sh
)

# docs/knowledge/ no se toca: template conserva sus plantillas vacías.
# docs/decisions/ y docs/board.json se regeneran limpios más abajo.

cd "$(git rev-parse --show-toplevel)"

if [ -n "$(git status --porcelain)" ]; then
  echo "Hay cambios sin commitear. Commitéalos o descártalos antes de sincronizar." >&2
  exit 1
fi

git checkout "$SOURCE_BRANCH"
git pull --ff-only
git checkout "$TEMPLATE_BRANCH"
git pull --ff-only

# Si la rama ya existe, se reutiliza para seguir commiteando en ella
if git show-ref --verify --quiet "refs/heads/$TARGET_BRANCH"; then
  echo "La rama $TARGET_BRANCH ya existe: se reutiliza."
  git checkout "$TARGET_BRANCH"
  if git rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1; then
    git pull --ff-only
  fi
elif git ls-remote --exit-code --heads origin "$TARGET_BRANCH" >/dev/null 2>&1; then
  echo "La rama $TARGET_BRANCH existe en origin: se reutiliza."
  git fetch origin "$TARGET_BRANCH"
  git checkout -b "$TARGET_BRANCH" --track "origin/$TARGET_BRANCH"
else
  git checkout -b "$TARGET_BRANCH"
fi

for path in "${BASE_PATHS[@]}"; do
  git rm -r -q --ignore-unmatch -- "$path"
  git checkout "$SOURCE_BRANCH" -- "$path"
done

# -f: los excluidos quedan en staging tras copiar su carpeta desde main
git rm -r -q -f --ignore-unmatch -- "${EXCLUDED_PATHS[@]}"

cat > docs/board.json <<'EOF'
{
  "proyecto": "nombre-del-proyecto",
  "actualizado": "YYYY-MM-DD",
  "tareas": [],
  "meta": {
    "inicializado": false,
    "ultimo_id": "0000",
    "historial": []
  }
}
EOF

cat > docs/decisions/INDEX.md <<'EOF'
# Índice de decisiones

Leer este archivo al inicio de sesión en lugar de las últimas 3 entradas individuales.
Actualizar al confirmar cada nueva decisión: agregar a la sección temática correspondiente y mover a "Recientes".

---

## Recientes

*Sin decisiones confirmadas todavía.*

---
EOF

touch docs/decisions/.gitkeep
git add docs/board.json docs/decisions/INDEX.md docs/decisions/.gitkeep

echo "------------------------------------------------------------"
git status --short
echo "------------------------------------------------------------"
echo "Rama $TARGET_BRANCH lista, sin commitear."
echo "Revisa que no se haya colado contexto propio del framework, luego commit y merge a $TEMPLATE_BRANCH."
