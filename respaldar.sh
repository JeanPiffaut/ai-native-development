#!/bin/bash
# Respaldo cifrado de los datos reales de compartido/ (entorno/*.md y avisos/*.md, que git ignora).
# Los cifra con age por frase de paso (interactivo: la frase la pide age y vive en tu gestor de
# contraseñas) en un solo archivo y lo sube a la rama "compartido" del repo PRIVADO de respaldos.
# Nunca va al repo público ai-native-development.
#
# Uso:  bash compartido/respaldar.sh            sube el respaldo
#       bash compartido/respaldar.sh restaurar  lo baja y lo descifra en entorno/ y avisos/ (no pisa
#                                               archivos existentes: los que choquen quedan como .restaurado)
# Requiere: age (brew install age), git y acceso al repo de respaldos (gh auth setup-git).
# Repo destino: COMPARTIDO_RESPALDO_REPO, por defecto el mismo de ia-docs (decisión 011 de fidelidad).

set -euo pipefail

AQUI="$(cd "$(dirname "$0")" && pwd)"
REPO="${COMPARTIDO_RESPALDO_REPO:-https://github.com/JeanPiffaut/ia-docs-respaldos.git}"
RAMA="compartido"
ARCHIVO="compartido.tar.age"

command -v age >/dev/null || { echo "Falta age: brew install age" >&2; exit 1; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
git init -q "$TMP/repo"
git -C "$TMP/repo" remote add origin "$REPO"

if [[ "${1:-}" == "restaurar" ]]; then
  git -C "$TMP/repo" fetch -q origin "$RAMA" || { echo "No hay respaldo en la rama $RAMA" >&2; exit 1; }
  git -C "$TMP/repo" checkout -q FETCH_HEAD
  age -d -o "$TMP/datos.tar" "$TMP/repo/$ARCHIVO"
  mkdir -p "$TMP/datos" && tar -xf "$TMP/datos.tar" -C "$TMP/datos"
  for f in $(cd "$TMP/datos" && find . -type f | sed 's#^\./##'); do
    destino="$AQUI/$f"
    if [[ -e "$destino" ]] && ! cmp -s "$TMP/datos/$f" "$destino"; then
      cp "$TMP/datos/$f" "$destino.restaurado"; echo "Ya existía y difiere: $f (respaldo en $f.restaurado)"
    elif [[ ! -e "$destino" ]]; then
      mkdir -p "$(dirname "$destino")"; cp "$TMP/datos/$f" "$destino"; echo "Restaurado: $f"
    fi
  done
  exit 0
fi

# Solo los archivos reales: los que git ignora dentro de entorno/ y avisos/.
cd "$AQUI"
REALES=$(git ls-files --others --ignored --exclude-standard entorno avisos | grep -E '\.md$' || true)
[[ -n "$REALES" ]] || { echo "No hay archivos reales que respaldar" >&2; exit 1; }
echo "$REALES" | tr '\n' '\0' | xargs -0 tar -cf "$TMP/datos.tar"
echo "Cifrando $(echo "$REALES" | wc -l | tr -d ' ') archivo(s); age pide la frase de paso dos veces."
age -p -o "$TMP/$ARCHIVO" "$TMP/datos.tar"

if git -C "$TMP/repo" ls-remote --exit-code --heads origin "$RAMA" >/dev/null 2>&1; then
  git -C "$TMP/repo" fetch -q origin "$RAMA"
  git -C "$TMP/repo" checkout -q -B "$RAMA" FETCH_HEAD
else
  git -C "$TMP/repo" checkout -q --orphan "$RAMA"
fi
cp "$TMP/$ARCHIVO" "$TMP/repo/$ARCHIVO"
printf '# compartido (respaldo cifrado)\n\nDatos reales de Proyectos/compartido cifrados con age por frase de paso. Restaurar con `bash compartido/respaldar.sh restaurar`.\n' > "$TMP/repo/README.md"
git -C "$TMP/repo" add -A
NOMBRE=$(git config user.name || echo respaldo); CORREO=$(git config user.email || echo respaldo@localhost)
git -C "$TMP/repo" -c user.name="$NOMBRE" -c user.email="$CORREO" commit -q -m "Respaldo cifrado de compartido $(date +%F)"
git -C "$TMP/repo" push -q origin "$RAMA"
echo "Respaldo cifrado subido a $REPO (rama $RAMA)."
