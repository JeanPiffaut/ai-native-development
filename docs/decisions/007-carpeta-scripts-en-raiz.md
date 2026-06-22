# [007] Carpeta scripts/ en raíz para automatización del proyecto

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al crear scripts de análisis de calidad (SonarQube), surgió la necesidad de definir dónde viven los scripts de automatización del proyecto que no son código de la aplicación.

## Alternativas consideradas

### Opción A — Scripts dentro de src/
- Pro: todo el código en un lugar.
- Contra: mezcla código de aplicación con herramientas de desarrollo. Los scripts no forman parte del bundle ni del runtime.

### Opción B — Scripts en package.json como inline commands
- Pro: sin archivos adicionales.
- Contra: no escala para scripts con lógica. Difícil de mantener y documentar.

### Opción C — Carpeta scripts/ en raíz (elegida)
- Pro: separación clara entre código de aplicación y herramientas de desarrollo. Fácil de encontrar y referenciar desde adapters.
- Contra: ninguno significativo.

## Decisión

Los scripts de automatización del proyecto viven en `scripts/` en la raíz, al mismo nivel que `docs/` y `src/`. No forman parte del bundle de la aplicación.

## Consecuencias

- `scripts/` contiene herramientas de desarrollo y CI, no lógica de negocio
- Los adapters que documentan herramientas pueden referenciar sus scripts en `scripts/`
- Los scripts se documentan en el adapter de la herramienta correspondiente, no en un archivo separado
