# [010] Git es una operación humana exclusiva — los agentes no ejecutan comandos git

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al definir los límites del agente de IA, se evaluó si debía poder ejecutar operaciones git (commit, push, branch, merge, etc.) como parte de su flujo de trabajo.

## Alternativas consideradas

### Opción A — El agente puede ejecutar git
- Pro: flujo más ágil. El agente puede hacer commit al terminar una tarea sin intervención humana.
- Contra: elimina el punto de revisión más importante del proceso. Un commit del agente sin revisión puede introducir código incorrecto, decisiones mal tomadas o cambios no deseados en el historial. El costo de un error no detectado es alto.

### Opción B — Git es operación humana exclusiva (elegida)
- Pro: garantiza revisión humana antes de cada commit. El agente puede preparar y sugerir, pero el humano ejecuta. Mantiene la responsabilidad del historial en manos del developer.
- Contra: agrega un paso manual. Aceptable — es precisamente el paso que queremos mantener.

## Decisión

Los agentes de IA no ejecutan operaciones git de ningún tipo. Pueden sugerir qué commitear, con qué mensaje y en qué rama, pero la ejecución es siempre humana.

## Consecuencias

- Prohibición explícita en `CONSTITUTION.md §2` y en `standards/agentes.md`
- No existe adapter de git con instrucciones para el agente — si se crea documentación de convenciones git, es referencia humana
- El punto de control entre el trabajo del agente y el repositorio es el commit humano
