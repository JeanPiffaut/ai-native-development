# [018] Flujo de inicialización que adapta el framework a cada proyecto, sea o no de software

- **Estado:** BORRADOR
- **Fecha:** 2026-09-28
- **Supera a:** —
- **Superada por:** —

---

## Contexto

La rama `template` es la base limpia que se lleva a cada proyecto nuevo. Hasta ahora, llevarla a un proyecto significaba copiarla tal cual y llenar `knowledge/` a mano. Eso tiene dos problemas:

- La base trae elementos pensados para software (`standards/clean-code.md`, `standards/clean-architecture.md`, adapters de NestJS, Jest, TypeScript…) que no aplican a proyectos de otra naturaleza: documentación, investigación, análisis de datos, operación, contenido.
- No existe un paso definido para adaptar flujos, standards o documentación al tipo de proyecto. Cada adaptación queda a criterio de la sesión y sin trazabilidad.

Además se van a inicializar repositorios que ya existen, con su propia estructura, así que la base no puede asumir que el proyecto parte de cero.

## Alternativas consideradas

### Opción A — Template único, se usa tal cual
- Pro: simple; cero pasos adicionales.
- Contra: fuerza convenciones de software en proyectos que no lo son; los elementos que no aplican quedan como ruido o se ignoran en silencio.

### Opción B — Variantes de template por tipo de proyecto (ramas o tags `template-nestjs`, `template-docs`…)
- Pro: cada variante viene lista para su tipo.
- Contra: multiplica las bases que hay que mantener sincronizadas a mano ([005]); no cubre proyectos mixtos ni tipos no previstos.

### Opción C — Base única + flujo de inicialización que la adapta (elegida)
- Pro: una sola base que mantener; cada proyecto decide qué conserva, qué ajusta y qué agrega, con trazabilidad en decisiones; sirve para cualquier tipo de proyecto, incluidos los que ya existen.
- Contra: la primera sesión en cada proyecto es más larga y requiere varias aprobaciones humanas. Aceptable — es justamente el momento en que el humano debe decidir cómo se trabaja.

## Decisión

- `board.json` incorpora `meta.inicializado`. En la rama `template` vale `false`.
- `CONSTITUTION.md §1`: si `meta.inicializado` es `false`, el agente sigue `standards/inicializacion.md` en lugar del protocolo normal.
- `standards/inicializacion.md` define el flujo: diagnóstico → tipo de proyecto y entregables → knowledge → ajuste del marco de trabajo → decisiones → cierre.
- Durante la inicialización todo el marco es ajustable, incluida la `CONSTITUTION.md`, siempre con aprobación humana explícita.
- El framework deja de asumir que el proyecto es de software.

## Consecuencias

- La rama `template` debe llevar `meta.inicializado: false`, `standards/inicializacion.md` y `templates/prompt-inicializacion.md`.
- Se descarta el plan de variantes de template por tipo de proyecto mencionado en `knowledge/negocio.md`.
- `standards/clean-code.md` y `standards/clean-architecture.md` siguen en la base, pero cada proyecto decide en la inicialización si aplican.
- El README y `knowledge/negocio.md` se actualizan para reflejar el nuevo modo de uso.
- Los proyectos ya inicializados (como este) llevan `meta.inicializado: true`.

## Referencias

- [005] Sincronización manual del framework — la base sigue siendo única y se mantiene a mano
- [016] Prompt de extracción de idea — insumo opcional del paso de diagnóstico
- [017] Rama git por tarea — ejemplo de regla que un proyecto sin git puede descartar al inicializarse
- Tareas 0004 y 0005 en `board.json`
