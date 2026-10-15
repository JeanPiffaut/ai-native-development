---
name: cerrar
description: Cierra la sesión de trabajo según docs/CONSTITUTION.md §6 — actualiza la documentación tocada, presenta los borradores para que el humano los cierre y deja el board al día. Cierra la sesión, no una tarea.
disable-model-invocation: true
---

Cierra la sesión según `docs/CONSTITUTION.md` §6. Esta skill no cierra tareas por sí sola: solo marca como completadas las que el humano confirme.

## 1. Revisar lo trabajado

Consulta git (rama actual, cambios sin commitear, commits de la rama) y repasa la sesión: qué tareas se tocaron y qué archivos cambiaron.

## 2. Documentación

Verifica que lo trabajado quedó reflejado donde corresponde y corrige lo que falte:
- `## Historial de cambios` en cada standard editado (`docs/standards/convenciones.md`)
- `docs/decisions/INDEX.md`, adapters, README u otros documentos que describan lo que cambió
- Si algo cambia `docs/knowledge/`, propónlo; no lo edites sin aprobación (§2)

## 3. Borradores

Lista las decisiones en `BORRADOR` y cualquier otra propuesta pendiente de aprobación. Para cada una, resume en una línea qué decide y pregunta si se confirma, se ajusta o se descarta. Confirma solo con aprobación explícita, con la skill `decision`.

## 4. Board

Actualiza `docs/board.json` con la skill `board`:
- Tareas trabajadas: `estado` y `notas` al día
- Tareas que el humano confirma como completadas: a `meta.historial` si tienen `decision_relacionada`, recrear si son recurrentes, y eliminar de `tareas`
- Tareas nuevas descubiertas en la sesión, si no se agregaron ya

## 5. Resumen

- Qué se hizo
- Qué quedó pendiente, y qué espera aprobación del humano
- Qué commitear y mensaje sugerido. No ejecutes commit, push ni merge
