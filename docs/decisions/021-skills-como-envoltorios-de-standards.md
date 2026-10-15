# [021] Skills de Claude Code como envoltorios delgados de CONSTITUTION y standards

- **Estado:** BORRADOR
- **Fecha:** 2026-10-15
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Los procedimientos de inicio de sesión, arranque de tarea y cierre de sesión se ejecutan a mano en cada sesión, y el formato de lo que el agente entrega varía. Además, con el método de estudio ([020]) hace falta una forma directa de pedir una ficha.

Claude Code permite definir skills invocables como comandos (`/nombre`). Solo las descubre en `.claude/skills/<nombre>/SKILL.md` (del directorio de inicio y sus padres hasta la raíz del repositorio); una skill dentro de `docs/` no se carga.

Hay dos restricciones del framework: debe seguir siendo agnóstico al orquestador (principio 1), y el protocolo no puede duplicarse en varias fuentes, porque se desalinean (por eso `standards/agentes.md` remite a `CONSTITUTION.md §1` en lugar de copiarlo).

## Alternativas consideradas

### Opción A — Sin skills
- Pro: cero archivos específicos de una herramienta.
- Contra: los procedimientos se repiten a mano y el formato de las declaraciones depende de cada sesión.

### Opción B — Skills en `docs/skills/`
- Pro: todo el framework en `docs/`.
- Contra: Claude Code no las descubre; serían markdown sin efecto.

### Opción C — Comandos en `.claude/commands/`
- Pro: funciona igual que una skill para invocar con `/`.
- Contra: es el formato heredado; las skills permiten archivos de apoyo y control de invocación, y la documentación las recomienda para trabajo nuevo.

### Opción D — Skills en `.claude/skills/` como envoltorios delgados (elegida)
- Pro: Claude Code las descubre; el procedimiento sigue viviendo en `CONSTITUTION.md` y `standards/`, así que no se duplica; otro orquestador puede crear sus equivalentes apuntando a las mismas secciones.
- Contra: archivos específicos de Claude Code en la raíz. Se acepta: el framework ya prevé que las convenciones del orquestador coexistan sin modificar `docs/` (`standards/agentes.md`, compatibilidad).

## Decisión

- Cuatro skills en `.claude/skills/`: `/iniciar` (inicio de sesión), `/tarea <id>` (análisis completo de una tarea para trabajarla en conjunto), `/cerrar` (cierre de sesión, no de tarea) y `/estudiar <tema>` (ficha de estudio).
- `/iniciar`, `/tarea` y `/cerrar` con `disable-model-invocation: true`: las dispara el humano. `/estudiar` permite la invocación del modelo para que el humano pueda pedir una ficha en lenguaje natural; su `description` la restringe a pedidos explícitos del humano, en línea con `standards/estudio.md` (el agente sugiere, no crea).
- Son envoltorios: ordenan pasos y fijan formatos de salida; las reglas viven en `CONSTITUTION.md` y `standards/`. Una regla nueva se propone en el standard, no en la skill.
- Son genéricas: no referencian decisiones y viajan a `template` (`.claude/skills` se agrega a `BASE_PATHS` de `scripts/sync-template.sh`).
- `adapters/claude.md` documenta las skills y las reglas para crearlas.

## Consecuencias

- `CLAUDE.md` sigue disparando el protocolo automáticamente; `/iniciar` sirve para fijar el formato de la declaración y para reiniciar el contexto a mitad de sesión.
- Al cambiar una sección de `CONSTITUTION.md` o de un standard que una skill referencia, hay que revisar la skill.
- Otros orquestadores no tienen skills hasta que alguien cree su adapter con equivalentes.

## Referencias

- [019] Sincronización de template por script
- [020] Fichas de estudio a pedido
- Documentación de skills de Claude Code: https://code.claude.com/docs/en/skills (consultada 2026-10-15)
- Tarea 0009 en `board.json`
