# Inicialización

- **Última actualización:** 2026-09-28

---

## Propósito

El framework se distribuye como una base genérica (rama `template`). Esa base no está pensada para un tipo de proyecto concreto: cada proyecto la adapta la primera vez que se usa, según lo que realmente necesita.

La inicialización es ese paso de adaptación. Al terminarla, el proyecto tiene su contexto (`knowledge/`), sus reglas de trabajo (`standards/`, `adapters/`, `templates/` y, si hace falta, `CONSTITUTION.md`) y su board inicial — ajustados a su naturaleza, sea o no un proyecto de software.

---

## Cuándo aplica

Cuando `board.json` tiene `meta.inicializado: false`.

Mientras el proyecto no esté inicializado, el agente sigue este flujo en lugar del ciclo estándar de `standards/flujo.md`. No se aborda ninguna otra tarea hasta completarlo.

---

## Principios de la inicialización

- **El agente propone, el humano aprueba** — cada paso termina con aprobación explícita antes de pasar al siguiente
- **Todo es ajustable** — la base es un punto de partida, no un molde. Se pueden eliminar, ajustar o crear standards, adapters, templates y flujos. `CONSTITUTION.md` también puede ajustarse, siempre con aprobación explícita del humano
- **Diagnosticar antes de preguntar** — lo que se puede inferir del repositorio se infiere y se presenta como suposición a confirmar; se pregunta solo lo que no se puede inferir
- **No inventar contexto** — si falta información de negocio, la sección queda marcada como pendiente y se pregunta
- **Todo ajuste relevante queda como decisión** — si se descarta, adapta o agrega algo de la base, se registra el porqué

---

## Pasos

### 0. Preparación
- Crear en el board la tarea `0001` — "Inicializar el framework en el proyecto", tipo `proceso`, estado `haciendo`, `decision_relacionada: "001"`
- Si el proyecto usa git, aplicar rama por tarea (ver `standards/flujo.md` paso 3): `proceso/0001-inicializacion`

### 1. Diagnóstico
Leer lo que ya existe en el repositorio: README, estructura de carpetas, código, manifiestos de dependencias, documentación previa, configuración de CI o infraestructura.

Si el humano trae un resumen generado con `templates/prompt-inicializacion.md`, usarlo como fuente principal para el contexto de negocio.

**Entrega:** resumen de lo encontrado, con las suposiciones marcadas como tales.

### 2. Tipo de proyecto y entregables
Acordar con el humano:
- **Tipo de proyecto** — software, documentación, investigación, análisis de datos, operación o infraestructura, contenido, mixto u otro
- **Qué produce** — los entregables concretos del proyecto
- **Dónde viven los entregables** — `src/` por defecto; si el repositorio ya tiene una estructura propia, se respeta y se documenta
- **Herramientas** — qué tecnologías, plataformas o herramientas usa

### 3. Knowledge
Completar `knowledge/` (`negocio.md`, `dominio.md`, `stakeholders.md`, `principios.md`) usando `templates/knowledge.md` como base. Crear archivos adicionales si el proyecto lo requiere.

### 4. Marco de trabajo
Revisar cada área y proponer para cada elemento: **mantener**, **ajustar**, **eliminar** o **crear**.

| Área | Pregunta guía |
|---|---|
| `standards/` | ¿Aplica a este proyecto? Ej.: `clean-code.md` y `clean-architecture.md` solo aplican si el proyecto produce código |
| `standards/flujo.md` | ¿El ciclo de tarea refleja cómo trabaja este proyecto? (revisiones, entregas, aprobaciones, publicación) |
| `adapters/` | ¿El proyecto usa esta herramienta? Eliminar los que no; crear los que falten |
| `templates/` | ¿Qué documentos recurrentes produce el proyecto? (informes, actas, especificaciones, guiones…) |
| Tipos de tarea del board | ¿`feature`, `bug`, `deuda`… describen el trabajo de este proyecto? Ajustar si es de otra naturaleza |
| `CONSTITUTION.md` | ¿Alguna regla no aplica o falta alguna? Ej.: un proyecto sin git no necesita la regla de rama por tarea |

Eliminar archivos y modificar `CONSTITUTION.md` requieren aprobación explícita (`CONSTITUTION.md §2`). Los standards editados registran el cambio en su `## Historial de cambios`.

### 5. Decisiones
- Crear `001` — adopción del framework en el proyecto, incluyendo el tipo de proyecto acordado en el paso 2
- Crear una decisión por cada ajuste relevante del paso 4 (ej.: "se descarta clean-architecture: el proyecto no produce código")
- Crear `decisions/INDEX.md` con las decisiones registradas
- Todas nacen como `BORRADOR` y se confirman solo con aprobación humana

### 6. Cierre
- Proponer el board inicial con las primeras tareas del proyecto (autoconclusivas, ver `standards/agentes.md`)
- Cambiar `meta.inicializado` a `true`
- Completar la tarea `0001` (registrar en `meta.historial` y eliminarla de `tareas`)
- Resumir al humano qué quedó definido, qué quedó pendiente de su aprobación y qué commitear

---

## Después de la inicialización

Los ajustes posteriores al marco de trabajo no requieren reinicializar: se tratan como tareas normales del board, con su decisión correspondiente cuando aplique.

---

## Lo que este estándar no hace

- No borra ni mueve archivos del proyecto fuera de `docs/` sin aprobación
- No completa `knowledge/` con contenido inventado
- No reemplaza el protocolo de `CONSTITUTION.md` una vez que el proyecto está inicializado
