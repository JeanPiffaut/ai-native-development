# [011] decisions/INDEX.md como mecanismo de descubribilidad a escala

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

El protocolo de inicio de sesión definido en `CONSTITUTION.md §1` indica leer las últimas 3 entradas en `decisions/`. Esto funciona bien con pocas decisiones, pero en un proyecto de meses el directorio puede acumular 50 o más ADRs. El problema no es el volumen — es que una decisión crítica de arquitectura tomada en el mes 1 se vuelve invisible para un agente nuevo que solo lee las últimas 3. La trazabilidad existe pero no es accesible.

## Alternativas consideradas

### Opción A — Mantener "últimas 3 entradas"
- Pro: sin cambios al protocolo, sin fricción adicional.
- Contra: las decisiones antiguas pero vigentes se pierden del contexto del agente. Un agente nuevo puede repetir una decisión ya tomada o contradecir una que no vio.

### Opción B — Leer todas las decisiones al inicio
- Pro: contexto completo.
- Contra: con 50+ archivos, el contexto del agente se satura. Impracticable a escala.

### Opción C — decisions/INDEX.md (elegida)
Un índice temático mantenido por el agente, organizado por área. Incluye una sección "Recientes" con las últimas 3-5 decisiones para contexto de cambios recientes. El agente lee un solo archivo en lugar de N archivos individuales.
- Pro: escala sin saturar contexto. Organiza por relevancia temática, no por orden cronológico. Un agente puede encontrar la decisión relevante sin escanear todo el directorio.
- Contra: requiere mantener el INDEX actualizado al confirmar cada nueva decisión. Si no se mantiene, pierde valor.

## Decisión

Se crea `decisions/INDEX.md` como índice temático de todas las decisiones confirmadas. El protocolo de inicio de sesión lee el INDEX en lugar de las últimas 3 entradas individuales. El agente es responsable de actualizar el INDEX cada vez que confirma una nueva decisión.

## Consecuencias

- `CONSTITUTION.md §1` punto 6 cambia de "últimas 3 entradas en decisions/" a "decisions/INDEX.md"
- `standards/agentes.md` protocolo de inicio actualizado acorde
- El agente actualiza INDEX.md al confirmar cada ADR nuevo, antes de cerrar la sesión
- El INDEX tiene siempre una sección "Recientes" con las últimas 3-5 decisiones para cubrir el contexto temporal
- Si el INDEX no existe en un proyecto clonado, el agente lo crea en la primera sesión

## Referencias

- Supera la limitación implícita del protocolo de inicio definido en [001]
- Relacionado con [012] (tipo recurrente), creado en la misma sesión de diseño
