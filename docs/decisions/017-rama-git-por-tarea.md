# [017] Cada tarea del board se trabaja en su propia rama git; el agente puede actualizar main y crear ramas

- **Estado:** BORRADOR
- **Fecha:** 2026-09-28
- **Supera a:** 010 *(parcialmente — solo en las operaciones git listadas abajo)*
- **Superada por:** —

---

## Contexto

La [010] prohíbe al agente ejecutar cualquier operación git. En la práctica eso obliga al humano a preparar el terreno de cada tarea (ir a main, traer cambios, crear la rama) antes de que el agente trabaje, y cuando no lo hace, el trabajo del agente cae directo sobre `main`.

Se quiere que `main` se mantenga limpio: todo cambio llega a `main` solo a través de un merge hecho por el humano. Para eso, cada tarea del board debe vivir en su propia rama, y el agente necesita permisos mínimos para crear esa rama desde un `main` actualizado.

El punto de control que protegía la [010] —la revisión humana antes de que algo entre al historial— se mantiene: commit, push y merge siguen siendo exclusivamente humanos.

## Alternativas consideradas

### Opción A — Mantener la [010] tal cual
- Pro: cero riesgo de que el agente toque el repositorio.
- Contra: el humano crea todas las ramas a mano; si lo olvida, el agente trabaja sobre `main` y se pierde la limpieza.

### Opción B — El agente también commitea en la rama de la tarea
- Pro: flujo más ágil; el humano solo revisa y hace merge.
- Contra: el historial de la rama lo escribe el agente sin revisión previa. Se descarta: el commit es el punto de control que se quiere conservar.

### Opción C — El agente actualiza main y crea/cambia de rama; commit, push y merge son humanos (elegida)
- Pro: `main` queda limpio por construcción; el humano conserva el control del historial; el agente arranca cada tarea en el lugar correcto sin intervención.
- Contra: el agente ejecuta comandos que cambian el estado del working tree (checkout). Se mitiga exigiendo árbol limpio antes de cualquier operación.

## Decisión

**Una tarea = una rama.** Toda tarea del board se trabaja en una rama propia creada desde `main` actualizado. Nunca se trabaja directamente sobre `main`.

**Nombre de rama:** `<tipo>/<id>-<slug-en-kebab-case>`, donde `tipo` e `id` son los de la tarea en el board.
Ejemplos: `feature/0002-prompt-inicializacion`, `proceso/0003-rama-git-por-tarea`.

**Operaciones git permitidas al agente (y solo estas):**

| Operación | Comando |
|---|---|
| Consultar estado (solo lectura) | `git status`, `git branch`, `git log`, `git diff` |
| Cambiar a main | `git checkout main` |
| Actualizar main | `git pull --ff-only` (estando en `main`) |
| Crear la rama de la tarea desde main | `git checkout -b <tipo>/<id>-<slug>` |
| Retomar una tarea existente | `git checkout <tipo>/<id>-<slug>` |

**Operaciones que siguen siendo exclusivamente humanas:** commit, push, merge, rebase, reset, stash, borrar ramas, tags y cualquier otra no listada arriba.

**Precondición:** antes de cambiar de rama, el agente verifica con `git status` que no haya cambios sin commitear. Si los hay, o si `git pull --ff-only` falla, se detiene y avisa al humano — no hace stash, no descarta cambios, no intenta resolver.

**board.json viaja con la rama:** los cambios al board propios de la tarea (pasarla a `haciendo`, notas, eliminarla al completar) se hacen en la rama de la tarea y llegan a `main` con el merge del humano.

## Consecuencias

- `main` solo cambia por merges humanos.
- Se modifica `CONSTITUTION.md §2` ("Nunca permitido") para reflejar la excepción — requiere aprobación humana.
- Se actualizan `standards/agentes.md` (límites del agente y reglas del board) y `standards/flujo.md` (paso de rama en el ciclo de tarea).
- Riesgo aceptado: con varias ramas abiertas en paralelo, `board.json` puede generar conflictos de merge. Los resuelve el humano al hacer merge.
- Una tarea que no cabe en una rama razonable es señal de que no es autoconclusiva y debe dividirse (ver `standards/agentes.md` — "Definición de tareas").

## Referencias

- [010] Git es operación humana exclusiva — superada parcialmente por esta decisión
- Tarea 0003 en `board.json`
