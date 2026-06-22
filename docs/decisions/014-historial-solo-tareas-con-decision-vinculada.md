# [014] Historial del board limitado a tareas con decisión vinculada

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** 013
- **Superada por:** —

---

## Contexto

La decisión [013] estableció que `meta.historial` registra una entrada por cada tarea completada, sin distinción. El objetivo era mantener trazabilidad del trabajo pasado y continuidad de IDs.

En la práctica, la continuidad de IDs la garantiza `meta.ultimo_id` por sí solo — no depende del historial. Y registrar todas las tareas completadas genera ruido sin valor: una tarea de bug fix rutinario o una tarea de proceso puntual no aporta información útil en el historial a largo plazo.

El valor real de `meta.historial` es el vínculo entre trabajo realizado y decisiones tomadas. Sin ese vínculo, la entrada en historial no añade trazabilidad que no esté ya en `board.json` o en `decisions/`.

## Alternativas consideradas

### Opción A — Mantener historial de todas las tareas (decisión [013])
- Pro: registro completo de todo lo que se hizo.
- Contra: el historial crece con entradas sin valor de trazabilidad. Dificulta encontrar las entradas relevantes. La continuidad de IDs no lo requiere.

### Opción B — Historial solo para tareas con decision_relacionada (elegida)
Registrar en `meta.historial` únicamente las tareas que tienen `decision_relacionada` distinto de null.
- Pro: el historial es denso en información — cada entrada apunta a un ADR que explica el contexto. Tareas rutinarias se eliminan limpiamente sin ruido. `ultimo_id` sigue garantizando la continuidad de IDs independientemente.
- Contra: se pierde el registro de tareas completadas sin decisión vinculada. Aceptable porque ese registro no tiene valor de trazabilidad.

## Decisión

`meta.historial` registra únicamente las tareas completadas que tienen `decision_relacionada` distinto de null. Las tareas sin decisión vinculada se eliminan de `tareas` directamente, sin entrada en historial.

`meta.ultimo_id` sigue actualizándose al crear cada tarea nueva, independientemente de si la tarea tendrá o no entrada en historial al completarse.

## Consecuencias

- `meta.historial` es un índice de trabajo con trazabilidad de decisión, no un log de actividad
- Las tareas rutinarias (bug fixes menores, tareas de proceso sin ADR) se eliminan limpiamente
- `standards/agentes.md` y `CONSTITUTION.md §4` y `§6` actualizados para reflejar la regla condicional
- `standards/calidad.md` checklist actualizado acorde

## Referencias

- Supera a [013] en la regla de cuándo registrar en `meta.historial`; la sección `meta` y el campo `ultimo_id` de [013] se mantienen sin cambios
