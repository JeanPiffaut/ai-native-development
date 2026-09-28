# [019] La rama template se sincroniza con un script que separa lo genérico de lo propio del proyecto

- **Estado:** CONFIRMADA
- **Fecha:** 2026-09-28
- **Supera a:** —
- **Superada por:** —

---

## Contexto

`main` es donde se trabaja el framework y `template` es la base limpia que se lleva a otros proyectos ([018]). Las dos ramas divergen a propósito: `main` tiene el knowledge, las decisiones y el board de este proyecto; `template` los tiene vacíos. Por eso no se puede hacer merge de `main` a `template`: arrastraría el contexto de este proyecto.

La [005] establece que la sincronización es manual. En la práctica, "manual" sin una lista escrita de qué se copia y qué no hizo que `template` quedara atrasada (sin `prompt-inicializacion.md`, sin `decisions/INDEX.md`, con reglas de git viejas).

## Alternativas consideradas

### Opción A — Copiar a mano cada vez
- Pro: cero herramientas nuevas.
- Contra: la lista de archivos genéricos vive en la memoria de quien sincroniza; fácil olvidar archivos o colar contexto del proyecto.

### Opción B — Merge de main a template y limpiar después
- Pro: git hace el trabajo pesado.
- Contra: cada merge mete knowledge, decisiones y board de este proyecto en `template`, y hay que limpiarlos siempre; un descuido contamina la base.

### Opción C — Script que ejecuta el humano (elegida)
- Pro: la lista de archivos genéricos queda escrita en un archivo; la sincronización es repetible; el resultado queda sin commitear en una rama para revisión humana.
- Contra: el script hay que mantenerlo cuando cambia la estructura de `docs/`.

## Decisión

- `scripts/sync-template.sh` crea una rama desde `template`, copia desde `main` como espejo exacto los archivos genéricos (`CLAUDE.md`, `README.md`, `.gitignore`, `.env.example`, `scripts/`, `docs/CONSTITUTION.md`, `docs/standards/`, `docs/adapters/`, `docs/templates/`) y regenera limpios `docs/board.json` (`inicializado: false`, sin tareas) y `docs/decisions/INDEX.md`.
- `docs/knowledge/` no se toca: `template` conserva sus plantillas vacías.
- El script no viaja a `template`: solo sirve para mantener el framework.
- Lo ejecuta el humano. El agente no lo corre, porque hace operaciones git fuera de las permitidas en [017] (checkout desde `template`, `git rm`).
- El commit y el merge a `template` siguen siendo humanos.

## Consecuencias

- Sigue vigente la [005]: la sincronización la decide y la dispara el humano; el script solo le quita trabajo mecánico.
- Si se agrega una carpeta o archivo genérico nuevo a la raíz o a `docs/`, hay que agregarlo a `BASE_PATHS` en el script.
- Los archivos genéricos no deben referenciar decisiones de este proyecto como fuente de una regla, porque en `template` `decisions/` está vacío.

## Referencias

- [005] Sincronización manual del framework
- [017] Rama git por tarea
- [018] Flujo de inicialización adaptable
- Tarea 0006 en `board.json`
