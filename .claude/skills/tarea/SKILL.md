---
name: tarea
description: Analiza a fondo una tarea del board para empezar a trabajarla en conjunto con el humano: alcance, decisiones y standards que aplican, ambigüedades y criterios de aceptación. Prepara la rama solo cuando hay acuerdo.
argument-hint: "[id]"
disable-model-invocation: true
---

Tarea a analizar: $ARGUMENTS

Si no se indicó un id, lista las tareas de `docs/board.json` y pide cuál. Si el id no existe en el board, pregunta antes de seguir (`docs/CONSTITUTION.md` §5).

## 1. Analizar

Lee la tarea completa (`contexto` y `notas`) y todo lo que la toca:
- Su `decision_relacionada` y las demás decisiones de `docs/decisions/INDEX.md` relacionadas con el tema
- Los standards con lectura condicional cuya condición cumple la tarea (campo `Lectura` en su encabezado) y los adapters que aplican
- Los archivos del proyecto que la tarea va a tocar

No uses `docs/estudio/` como contexto (ver `docs/standards/estudio.md`).

## 2. Presentar el análisis

- **Qué entrega** cuando esté lista, y qué queda fuera del alcance
- **Qué aplica** — decisiones, standards y adapters relevantes, en una línea cada uno
- **Conflictos** con decisiones confirmadas, si los hay (`docs/standards/calidad.md`)
- **Dudas y ambigüedades** que hay que resolver antes de empezar
- **Criterios de aceptación** — los registrados, o una propuesta si no hay
- **Conceptos para estudiar** — si la tarea introduce conceptos centrales sin ficha en `docs/estudio/`, menciónalos en una línea; no crees fichas

## 3. Acordar

Espera a que el humano resuelva las dudas y apruebe alcance y criterios. No propongas implementación todavía.

## 4. Preparar

Con el acuerdo:
- Registra los criterios de aceptación como primera entrada de `notas` (`docs/standards/calidad.md`)
- Prepara la rama `<tipo>/<id>-<slug-en-kebab-case>` (con `tipo` e `id` de la tarea), solo con las operaciones de `docs/standards/agentes.md` ("Sobre git"):
  1. `git status` — si hay cambios sin commitear, detente y avisa al humano (no hagas stash ni descartes nada)
  2. Si la rama ya existe: `git checkout <rama>`
  3. Si no existe: `git checkout main` → `git pull --ff-only` → `git checkout -b <rama>`
  4. Si `pull --ff-only` falla o hay cualquier error, detente y avisa al humano
- Pasa la tarea a `haciendo` (skill `board`)
- Sigue con el paso 2 de `docs/standards/flujo.md` ("Especificar"): el enfoque se debate antes de implementar
