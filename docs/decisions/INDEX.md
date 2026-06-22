# Índice de decisiones

Leer este archivo al inicio de sesión en lugar de las últimas 3 entradas individuales.
Actualizar al confirmar cada nueva decisión: agregar a la sección temática correspondiente y mover a "Recientes".

---

## Recientes

Las últimas decisiones confirmadas — para contexto de cambios recientes:

- **[013]** [meta en board.json para historial y continuidad de IDs](013-meta-en-board-para-historial-y-continuidad-de-ids.md) — sección `meta` al final del board con `ultimo_id` y `historial` mínimo de tareas completadas — 2026-06-22
- **[012]** [tipo recurrente en board.json](012-tipo-recurrente-en-board.md) — se agrega `recurrente` como tipo de tarea con campo `cadencia`; al completarse, el agente la re-crea para el próximo ciclo — 2026-06-22
- **[011]** [decisions/INDEX.md como mecanismo de descubribilidad](011-index-de-decisiones-para-descubribilidad.md) — el protocolo de inicio lee este INDEX en lugar de las últimas 3 entradas individuales — 2026-06-22

---

## Fundamentos del framework

- **[001]** [Adopción del framework AI-native](001-adopcion-framework-ai-native.md) — se adopta estructura de carpetas en el repositorio (CONSTITUTION, knowledge, decisions, standards, adapters) como base para cualquier proyecto con agentes de IA
- **[002]** [Estructura de docs/ en raíz](002-estructura-docs-en-raiz.md) — toda la documentación del framework vive en `docs/` dentro del repositorio, junto al código
- **[003]** [Separación standards vs adapters](003-separacion-standards-adapters.md) — standards aplican independientemente de la tecnología; adapters solo cuando el proyecto usa esa herramienta concreta

## Flujo de trabajo y proceso

- **[005]** [Sincronización manual del framework](005-sincronizacion-manual-del-framework.md) — los proyectos derivados no se sincronizan automáticamente; las mejoras se llevan manualmente al repo base
- **[006]** [Sin templates para board y adapters](006-sin-templates-para-board-y-adapters.md) — board.json y los adapters no tienen templates en `templates/`; su estructura está definida en los standards
- **[009]** [Tareas desde SonarQube son manuales](009-tareas-desde-sonarqube-son-manuales.md) — el developer decide qué issues de SonarQube merecen ser tareas; no hay script automático de volcado al board
- **[010]** [Git es operación humana exclusiva](010-git-es-operacion-humana.md) — los agentes nunca ejecutan comandos git

## Estructura de archivos y herramientas

- **[007]** [Carpeta scripts/ en raíz](007-carpeta-scripts-en-raiz.md) — las herramientas de automatización del proyecto viven en `scripts/` en la raíz, no en `docs/` ni en `src/`
- **[008]** [.tmp/ para reportes efímeros](008-tmp-para-reportes-efimeros.md) — los reportes generados por herramientas de análisis se guardan en `.tmp/` (gitignored); se procesan en la sesión o se vuelven a generar

## Configuración y entorno

- **[004]** [ENVIRONMENT sobre NODE_ENV](004-environment-sobre-node-env.md) — se usa la variable `ENVIRONMENT` en lugar de `NODE_ENV` como variable genérica de entorno del proyecto

## Gestión del board y decisiones

- **[011]** [decisions/INDEX.md como mecanismo de descubribilidad](011-index-de-decisiones-para-descubribilidad.md) — índice temático que el protocolo de inicio lee en lugar de las últimas 3 entradas
- **[012]** [tipo recurrente en board.json](012-tipo-recurrente-en-board.md) — tipo de tarea para trabajo periódico; incluye campo `cadencia` y protocolo de re-creación al completarse
- **[013]** [meta en board.json para historial y continuidad de IDs](013-meta-en-board-para-historial-y-continuidad-de-ids.md) — sección `meta` al final del board con `ultimo_id` y `historial` mínimo append-only de tareas completadas
