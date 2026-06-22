# [012] Tipo de tarea recurrente en board.json

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

El board.json maneja tareas de trabajo activo. Las tareas completadas se eliminan. Esto funciona bien para trabajo puntual, pero algunas tareas tienen que repetirse periódicamente — por ejemplo, revisar que las versiones en `adapters/` sigan siendo las estables actuales. Sin un mecanismo explícito, estas tareas dependen de que el developer las recuerde, y tienden a no hacerse.

El riesgo concreto: los adapters documentan versiones de herramientas (NestJS, TypeScript, Docker) que quedan obsoletas en meses. Un agente siguiendo un adapter desactualizado puede instalar versiones viejas sin saberlo.

## Alternativas consideradas

### Opción A — Agregar manualmente cuando se recuerde
Sin cambio al schema. El developer crea la tarea cuando la recuerda.
- Pro: sin complejidad adicional.
- Contra: se olvida sistemáticamente. No hay señal en el sistema que indique que algo necesita revisión periódica.

### Opción B — Campo `vigente_hasta` en adapters/
Agregar metadata de expiración a cada adapter. El agente detecta adapters vencidos al inicio de sesión.
- Pro: la señal vive junto al dato.
- Contra: agrega campos a todos los adapters existentes. Si el agente no los revisa, el campo no sirve. Mezcla metadata de proceso con contenido técnico.

### Opción C — tipo: recurrente en board.json (elegida)
Agregar `recurrente` como tipo válido de tarea. Las tareas recurrentes tienen un campo `cadencia` (mensual, trimestral, semestral). Cuando se completan, el agente las re-crea para el próximo ciclo antes de eliminar la actual.
- Pro: el mecanismo de recurrencia vive en el board, que ya es el lugar del trabajo activo. Simple de implementar, no requiere cambios a los adapters existentes. La tarea recurrente es autoconclusiva como cualquier otra.
- Contra: requiere disciplina del agente para re-crearla al completar. Si no se re-crea, el ciclo se rompe.

## Decisión

Se agrega `recurrente` al enum de `tipo` en el schema de `board.json`. Las tareas recurrentes incluyen un campo `cadencia` con el período de repetición. Al completar una tarea recurrente, el agente crea inmediatamente una nueva instancia para el próximo ciclo antes de eliminar la actual.

La primera tarea recurrente del framework es: revisar versiones de todos los adapters en `adapters/` y actualizarlas si hay versiones estables más recientes.

## Consecuencias

- `standards/agentes.md` actualizado con `recurrente` en el enum de tipo y reglas de manejo
- Las tareas recurrentes tienen campo `cadencia: "mensual | trimestral | semestral | anual"`
- Al completar una tarea recurrente: crear nueva instancia con `creada` actualizada, luego eliminar la completada
- La re-creación es responsabilidad del agente que completa la tarea, no del developer

## Referencias

- Relacionado con [011], creado en la misma sesión de diseño
- La tarea recurrente de revisión de adapters aborda el riesgo de versiones obsoletas identificado al analizar el decay del framework a escala
