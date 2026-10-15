---
name: inicializar
description: Adapta el framework a un proyecto la primera vez que se usa — diagnóstico, tipo de proyecto, knowledge, marco de trabajo, decisiones y board inicial. Usar cuando docs/board.json tiene meta.inicializado en false; mientras tanto no se aborda ninguna otra tarea.
---

El framework se distribuye como una base genérica. La inicialización la adapta a lo que este proyecto necesita, sea o no de software. Al terminar, el proyecto tiene su contexto (`docs/knowledge/`), sus reglas de trabajo (`docs/standards/`, `docs/adapters/`, `docs/templates/`, skills y, si hace falta, `docs/CONSTITUTION.md`) y su board inicial.

## Principios

- **El agente propone, el humano aprueba** — cada paso termina con aprobación explícita antes de pasar al siguiente
- **Todo es ajustable** — la base es un punto de partida, no un molde. Se pueden eliminar, ajustar o crear standards, adapters, templates, skills y flujos. `CONSTITUTION.md` también, siempre con aprobación explícita
- **Diagnosticar antes de preguntar** — lo que se puede inferir del repositorio se presenta como suposición a confirmar; se pregunta solo lo que no se puede inferir
- **No inventar contexto** — si falta información de negocio, la sección queda marcada como pendiente y se pregunta
- **Todo ajuste relevante queda como decisión** — si se descarta, adapta o agrega algo de la base, se registra el porqué

## Pasos

### 0. Preparación
- Crear en el board la tarea `0001` — "Inicializar el framework en el proyecto", tipo `proceso`, estado `haciendo`, `decision_relacionada: "001"`
- Si el proyecto usa git, aplicar rama por tarea (`docs/standards/flujo.md`): `proceso/0001-inicializacion`

### 1. Diagnóstico
Leer lo que ya existe en el repositorio: README, estructura de carpetas, código, manifiestos de dependencias, documentación previa, configuración de CI o infraestructura.

Si el humano trae un resumen generado con [assets/prompt-externo.md](assets/prompt-externo.md), usarlo como fuente principal para el contexto de negocio.

**Entrega:** resumen de lo encontrado, con las suposiciones marcadas como tales.

### 2. Tipo de proyecto y entregables
Acordar con el humano:
- **Tipo de proyecto** — software, documentación, investigación, análisis de datos, operación o infraestructura, contenido, mixto u otro
- **Qué produce** — los entregables concretos del proyecto
- **Dónde viven los entregables** — `src/` por defecto; si el repositorio ya tiene una estructura propia, se respeta y se documenta
- **Herramientas** — qué tecnologías, plataformas o herramientas usa

### 3. Knowledge
Completar `docs/knowledge/` (`negocio.md`, `dominio.md`, `stakeholders.md`, `principios.md`) usando `docs/templates/knowledge.md` como base. Crear archivos adicionales si el proyecto lo requiere.

### 4. Marco de trabajo
Revisar cada área y proponer para cada elemento: **mantener**, **ajustar**, **eliminar** o **crear**.

| Área | Pregunta guía |
|---|---|
| `docs/standards/` | ¿Aplica a este proyecto? ¿Su `Lectura` es correcta? Ej.: `clean-code.md` y `clean-architecture.md` solo aplican si el proyecto produce código |
| `docs/standards/flujo.md` | ¿El ciclo de tarea refleja cómo trabaja este proyecto? (revisiones, entregas, aprobaciones, publicación) |
| `docs/adapters/` | ¿El proyecto usa esta herramienta? Eliminar los que no; crear los que falten |
| `docs/templates/` | ¿Qué documentos recurrentes produce el proyecto? (informes, actas, especificaciones, guiones…) |
| Skills | ¿Qué procedimientos propios del proyecto conviene tener como skill? (monitoreos, reportes, despliegues, rutinas del dominio) |
| Tipos de tarea del board | ¿`feature`, `bug`, `deuda`… describen el trabajo de este proyecto? Ajustar si es de otra naturaleza |
| `docs/CONSTITUTION.md` | ¿Alguna regla no aplica o falta alguna? Ej.: un proyecto sin git no necesita la regla de rama por tarea |

Eliminar archivos y modificar `CONSTITUTION.md` requieren aprobación explícita (`CONSTITUTION.md §2`). Los standards editados registran el cambio en su `## Historial de cambios`.

### 5. Decisiones
Registrarlas con la skill `decision`:
- `001` — adopción del framework en el proyecto, incluyendo el tipo de proyecto acordado en el paso 2
- Una decisión por cada ajuste relevante del paso 4 (ej.: "se descarta clean-architecture: el proyecto no produce código")
- `docs/decisions/INDEX.md` con las decisiones registradas
- Todas nacen como `BORRADOR` y se confirman solo con aprobación humana

### 6. Cierre
- Proponer el board inicial con las primeras tareas del proyecto (autoconclusivas, ver `docs/standards/agentes.md`)
- Cambiar `meta.inicializado` a `true`
- Completar la tarea `0001` con la skill `board`
- Proponer al humano eliminar esta skill (`.claude/skills/inicializar/`, incluido el prompt externo): en el proyecto ya no tiene uso. Solo con su aprobación
- Resumir al humano qué quedó definido, qué quedó pendiente de su aprobación y qué commitear

## Lo que esta skill no hace

- No borra ni mueve archivos del proyecto fuera de `docs/` sin aprobación
- No completa `docs/knowledge/` con contenido inventado
- No se usa una vez que el proyecto está inicializado; los ajustes posteriores al marco de trabajo son tareas normales del board
