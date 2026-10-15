---
name: decision
description: Registra una decisión en docs/decisions/ como BORRADOR, o confirma una existente con aprobación humana y actualiza el índice. Usar cuando se elige una tecnología, se define una estructura o arquitectura, se establece una convención, se descarta una alternativa obvia o se resuelve un conflicto entre enfoques (docs/CONSTITUTION.md §3), y cuando el humano confirma una decisión.
---

Las reglas están en `docs/CONSTITUTION.md` §3 (cuándo registrar, append-only, confirmar solo con aprobación). Esta skill tiene los pasos.

## Registrar

1. **Número** — el siguiente correlativo a la última decisión en `docs/decisions/` (tres dígitos). Si un número se reservó para una decisión descartada, no se reutiliza.
2. **Archivo** — `docs/decisions/NNN-titulo-en-kebab-case.md`, a partir de `docs/templates/decision.md`.
3. **Contenido** — contexto, al menos dos alternativas con pro y contra, la decisión concreta y sus consecuencias. Si supera a otra, indicarlo en `Supera a` (y si es parcial, en qué).
4. **Estado** — `BORRADOR`.
5. **Presentar** — resumir al humano qué decide y qué alternativas se descartaron, y pedir confirmación. No implementar lo que dependa de la decisión hasta que se confirme, salvo que el humano lo pida.

Si la decisión está ligada a una tarea, poner su número en `decision_relacionada` de la tarea.

## Confirmar

Solo con aprobación explícita del humano.

1. Cambiar `Estado` a `CONFIRMADA`.
2. Si supera a otra decisión, completar en la anterior el campo `Superada por: NNN` (indicando *parcialmente* y en qué, si aplica). Es el único cambio permitido en una decisión ya confirmada; el resto de su contenido no se toca.
3. Actualizar `docs/decisions/INDEX.md`:
   - En "Recientes", agregar la nueva arriba (número, enlace, resumen en una línea, fecha) y dejar solo las tres últimas
   - Agregarla a la sección temática que corresponda, con su relación (`refina [NNN]`, `superada por [NNN]`)
   - Marcar en su sección temática a la decisión superada
