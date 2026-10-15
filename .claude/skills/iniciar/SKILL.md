---
name: iniciar
description: Inicia la sesión de trabajo siguiendo el protocolo de docs/CONSTITUTION.md §1 y declara contexto leído, estado del proyecto y tarea propuesta. Usar al comenzar una sesión o después de limpiar el contexto.
disable-model-invocation: true
---

Inicia la sesión según `docs/CONSTITUTION.md`. Esta skill no agrega reglas: ordena los pasos y fija el formato de la declaración.

1. Lee `docs/CONSTITUTION.md`. Si `docs/board.json` tiene `meta.inicializado: false`, sigue `docs/standards/inicializacion.md` y no continúes con esta skill.
2. Lee los archivos en el orden de §1. El adapter de la tarea se lee cuando se elige la tarea, no ahora. No leas `docs/estudio/` (ver `docs/standards/estudio.md`).
3. Consulta el estado de git con las operaciones permitidas en `docs/standards/agentes.md` ("Sobre git").
4. Declara, en este formato:

**Contexto leído** — archivos leídos; los que falten, señalados.

**Estado**
- Rama actual y si hay cambios sin commitear
- Tareas del board agrupadas por estado (`haciendo`, `bloqueado`, `pendiente`), con id, título y prioridad
- Tareas recurrentes cuya `cadencia` ya se cumplió desde `creada`
- Decisiones en `BORRADOR`, como pendientes de aprobación del humano

**Tarea propuesta** — cuál abordarías y por qué, en una o dos líneas.

5. No empieces ninguna tarea. Espera a que el humano elija (puede usar `/tarea <id>`).
