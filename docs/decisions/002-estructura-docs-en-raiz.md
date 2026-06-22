# [002] Mover documentación del framework a carpeta docs/

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al construir el framework, la primera versión colocaba todos los archivos de documentación en la raíz del repositorio junto al código. Esto producía una raíz desordenada al agregar el proyecto real (`src/`) y otras carpetas necesarias.

## Alternativas consideradas

### Opción A — Documentación en raíz
Todos los archivos (`CONSTITUTION.md`, `knowledge/`, `decisions/`, etc.) en la raíz del proyecto.
- Pro: acceso directo, sin subdirectorio.
- Contra: raíz mezclada con código fuente, configuración y otros archivos del proyecto real.

### Opción B — Carpeta docs/ (elegida)
Toda la documentación del framework vive en `docs/`. El proyecto real vive en `src/`. La raíz contiene solo `README.md`, `CLAUDE.md` y archivos de configuración del repositorio.
- Pro: separación clara entre documentación y código. Raíz limpia.
- Contra: las rutas internas dentro de `docs/` siguen siendo relativas entre sí, sin cambios.

## Decisión

Toda la documentación del framework vive en `docs/`. La raíz del proyecto queda limpia con `README.md`, `CLAUDE.md`, `.gitignore` y `src/`.

## Consecuencias

- `CLAUDE.md` en raíz apunta a `docs/CONSTITUTION.md`
- Todas las rutas en `CONSTITUTION.md` son relativas a `docs/` (sin prefijo)
- Al clonar para un nuevo proyecto, `src/` se crea al mismo nivel que `docs/`
