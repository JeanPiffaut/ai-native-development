#!/bin/bash
# Deja la rama "compartido" de ai-native-development en <Proyectos>/compartido y crea <Proyectos>/CLAUDE.md,
# que importa compartido/CLAUDE.md en las sesiones de todos los proyectos de esa carpeta.
# Uso: bash compartido/instalar.sh            (desde la carpeta Proyectos, o desde cualquier lado)
# Idempotente: si ya está instalado, solo verifica.

set -euo pipefail

AQUI="$(cd "$(dirname "$0")" && pwd)"
PROYECTOS="$(dirname "$AQUI")"
REPO_URL="https://github.com/JeanPiffaut/ai-native-development.git"

if [[ "$(basename "$AQUI")" != "compartido" ]]; then
  echo "instalar.sh debe estar en <Proyectos>/compartido (está en $AQUI)" >&2
  exit 1
fi

if ! git -C "$AQUI" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if [[ -d "$PROYECTOS/ai-native-development/.git" ]]; then
    echo "Falta el checkout: crea el worktree desde $PROYECTOS/ai-native-development" >&2
    echo "  git -C \"$PROYECTOS/ai-native-development\" worktree add \"$AQUI\" compartido" >&2
  else
    echo "Falta el checkout: git clone -b compartido $REPO_URL \"$AQUI\"" >&2
  fi
  exit 1
fi

CLAUDE_RAIZ="$PROYECTOS/CLAUDE.md"
LINEA="@compartido/CLAUDE.md"
if [[ -f "$CLAUDE_RAIZ" ]] && grep -qxF "$LINEA" "$CLAUDE_RAIZ"; then
  echo "OK: $CLAUDE_RAIZ ya importa compartido/CLAUDE.md"
elif [[ -f "$CLAUDE_RAIZ" ]]; then
  echo "$CLAUDE_RAIZ existe y no importa compartido/CLAUDE.md: agrega a mano la línea '$LINEA'" >&2
  exit 1
else
  printf '%s\n' "$LINEA" > "$CLAUDE_RAIZ"
  echo "Creado $CLAUDE_RAIZ"
fi

faltan=0
for ejemplo in "$AQUI"/entorno/*.example.md; do
  real="${ejemplo%.example.md}.md"
  [[ -f "$real" ]] || { echo "Falta el real: entorno/$(basename "$real") (copia el .example.md y complétalo)"; faltan=1; }
done
[[ $faltan -eq 0 ]] && echo "OK: todos los archivos de entorno/ tienen su versión real"
exit 0
