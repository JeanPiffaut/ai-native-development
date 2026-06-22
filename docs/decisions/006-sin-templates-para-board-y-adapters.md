# [006] No crear templates para board.json ni para adapters

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al revisar qué templates hacían falta en `templates/`, se evaluó si era necesario agregar templates para el board y para los adapters.

## Alternativas consideradas

### Opción A — Agregar templates para board y adapters
Un `templates/board.md` o `templates/adapter.md` que sirva de molde.
- Pro: consistencia garantizada al crear nuevos elementos.
- Contra: el esquema del board ya está documentado en `standards/agentes.md`. Los adapters existentes son la referencia más útil — leer cualquiera de ellos es más claro que un template vacío. Agregar templates duplicaría información ya disponible.

### Opción B — Sin templates adicionales (elegida)
Los templates existentes (`decision.md`, `knowledge.md`) son los que aportan valor real porque su estructura no es obvia. El board y los adapters tienen suficiente referencia en los archivos ya existentes.
- Pro: sin duplicación de información. El framework se mantiene simple.
- Contra: ninguno significativo dado el contexto.

## Decisión

No se crean templates para board.json ni para adapters. La referencia para el board es `standards/agentes.md`. La referencia para nuevos adapters son los adapters existentes en `adapters/`.

## Consecuencias

- `templates/` contiene solo `decision.md` y `knowledge.md`
- El agente que necesite crear un adapter nuevo debe leer los existentes como referencia
- Si en el futuro se detecta inconsistencia entre adapters, se puede reconsiderar con una nueva decisión
