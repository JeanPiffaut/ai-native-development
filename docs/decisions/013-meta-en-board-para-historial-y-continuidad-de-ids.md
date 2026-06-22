# [013] Sección meta en board.json para historial y continuidad de IDs

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** 014

---

## Contexto

El board.json elimina tareas al completarlas para mantenerse enfocado en el trabajo activo. Esto genera dos problemas cuando el board queda vacío o cuando un agente nuevo inicia sesión:

1. **Continuidad de IDs rota** — sin registro del último ID usado, un agente nuevo podría crear una tarea `0001` que ya existió, violando la regla de IDs únicos y nunca reutilizados.
2. **Historia de trabajo perdida** — no hay forma de saber qué se entregó recientemente ni qué decisiones surgieron de cada tarea completada. El vínculo entre trabajo y decisiones (`decision_relacionada`) desaparece al eliminar la tarea.

## Alternativas consideradas

### Opción A — Archivo separado board-historial.json
- Pro: board.json sigue limpio.
- Contra: agrega un archivo más al protocolo de lectura. Aumenta la fricción sin un beneficio proporcional.

### Opción B — Historial en decisions/
Las tareas completadas relevantes generan un ADR.
- Pro: ya existe el mecanismo.
- Contra: no toda tarea completada merece un ADR. El historial de trabajo y el historial de decisiones son cosas distintas.

### Opción C — Sección meta en board.json (elegida)
Agregar al final de `board.json` una sección `meta` con dos campos: `ultimo_id` (string con el último ID creado) e `historial` (array de entradas mínimas por tarea completada). Las tareas activas siguen primero en el archivo.
- Pro: todo en un lugar. `ultimo_id` es un campo de una línea. El historial es deliberadamente mínimo — solo referencia, no contexto; para el "por qué" se va a `decisions/`.
- Contra: el historial crece indefinidamente. Aceptable porque crece lento (una entrada por tarea completada) y cada entrada es mínima.

## Decisión

Se agrega la sección `meta` al final de `board.json`, después de `tareas`. Contiene:
- `ultimo_id`: string con el último ID de tarea creado. El agente lo actualiza cada vez que crea una tarea nueva.
- `historial`: array append-only de objetos con `id`, `titulo`, `completada` (fecha ISO) y `decision_relacionada` (número de ADR o null). El agente agrega una entrada cada vez que elimina una tarea completada.

El orden en el archivo es: `proyecto` → `actualizado` → `tareas` → `meta`. Las tareas activas van primero para que sean lo primero visible al abrir el archivo.

## Consecuencias

- Los IDs nunca se repiten, incluso cuando el board queda vacío entre sesiones
- Existe un rastro mínimo de qué se entregó y cuándo, vinculado a decisiones cuando aplica
- El historial no reemplaza a `decisions/` — solo registra qué pasó; el razonamiento vive en los ADRs
- `standards/agentes.md` actualizado con las reglas de mantenimiento de `meta`

## Referencias

- Relacionado con [011] y [012], diseñados en la misma sesión de evolución del framework
