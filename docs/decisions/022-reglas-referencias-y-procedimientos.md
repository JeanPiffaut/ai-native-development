# [022] Separar reglas, referencias condicionales y procedimientos; los procedimientos viven en skills

- **Estado:** CONFIRMADA
- **Fecha:** 2026-10-15
- **Supera a:** 021 (parcialmente: las skills dejan de ser solo envoltorios para los procedimientos)
- **Superada por:** —

---

## Contexto

El protocolo de inicio (`CONSTITUTION.md §1`) lee todo `standards/` en cada sesión. Medido el 2026-10-15, la lectura de inicio suma unas 9.500 palabras, de las cuales `standards/` aporta 5.463 (57%). Buena parte de ese contenido no hace falta en cada sesión:

- Procedimientos que se usan rara vez o solo en ciertos momentos: `inicializacion.md` (una vez por proyecto), cómo armar una ficha de estudio, cómo proponer una decisión, el esquema del board, la creación de la rama de una tarea
- Referencias que solo aplican a ciertas tareas: `clean-code.md` y `clean-architecture.md`, que solo sirven cuando la tarea produce código

Las skills (formato abierto `SKILL.md`, especificado en agentskills.io) se cargan por divulgación progresiva: al inicio solo entran nombre y descripción (~100 tokens por skill); el cuerpo, cuando se usa. Pero la activación de una skill por el modelo no está garantizada, así que una regla que debe aplicar siempre no puede depender de ella.

La carpeta de skills no es uniforme entre herramientas: Claude Code documenta solo `.claude/skills`; Codex solo `.agents/skills`; Gemini CLI `.gemini/skills` y `.agents/skills`; Cursor `.agents/skills`, `.cursor/skills` y `.claude/skills` por compatibilidad; VS Code/Copilot `.github/skills`, `.claude/skills` y `.agents/skills`.

## Alternativas consideradas

### Opción A — Dejar todo en `standards/` y leerlo siempre
- Pro: una sola fuente, sin dependencia de ningún mecanismo de carga.
- Contra: el costo de contexto crece con cada standard nuevo, aunque la tarea no lo necesite.

### Opción B — Mover standards completos a skills
- Pro: máximo ahorro de contexto.
- Contra: reglas que deben aplicar siempre (permisos, git, append-only, `estudio/` fuera del contexto) quedarían sujetas a que el modelo cargue la skill.

### Opción C — Tres tipos de contenido, cada uno con su forma de carga (elegida)
- Pro: las reglas se siguen leyendo siempre; lo demás se carga solo cuando aplica; la referencia condicional no necesita skills, así que funciona con cualquier orquestador.
- Contra: el contenido queda en más lugares, y hay que mantener la referencia entre la regla y su procedimiento.

Para la ubicación de las skills:

### Opción C1 — `.claude/skills` + lectura directa como respaldo (elegida)
- Pro: funciona hoy en Claude Code, Copilot y Cursor sin configuración extra; cualquier otro agente puede leer el `SKILL.md` como Markdown.
- Contra: Codex y Gemini CLI no las descubren solas.

### Opción C2 — `.agents/skills` como fuente y `.claude/skills` como symlink
- Pro: cubre a las herramientas que siguen `.agents/skills`.
- Contra: no está documentado que Claude Code siga symlinks; los symlinks en git dan problemas en Windows. Se puede revisar más adelante.

## Decisión

**Tres tipos de contenido:**

| Tipo | Qué es | Dónde vive | Cuándo se lee |
|---|---|---|---|
| Regla | Lo que debe cumplirse siempre | `CONSTITUTION.md` y `standards/` | Siempre, al inicio de sesión |
| Referencia condicional | Criterios que solo aplican a cierto tipo de tarea | `standards/`, con su condición declarada en el encabezado | Cuando la tarea cumple la condición |
| Procedimiento | Pasos para hacer algo concreto | Una skill en `.claude/skills/` | Cuando se va a hacer eso |

- **Lectura condicional declarada:** cada standard indica en su encabezado `Lectura: siempre` o `Lectura: cuando <condición>`. `§1` lee al inicio solo los de "siempre"; los condicionales se leen al empezar una tarea que cumple la condición, igual que los adapters.
- **La regla nombra a su procedimiento:** cuando un procedimiento sale de un standard, la regla que se queda indica qué skill seguir (ej. "para registrar una decisión, seguir la skill `decision`"). La regla obliga; el detalle se carga cuando hace falta.
- **Para los procedimientos, la skill es la fuente.** Supera en ese punto a [021]: las skills dejan de ser solo envoltorios. Las skills que solo ordenan pasos de un standard siguen siendo envoltorios.
- **Respaldo agnóstico:** `CONSTITUTION.md` indica que, si el orquestador no soporta skills o no carga la que corresponde, el agente lee el `SKILL.md` directamente por su ruta.
- **Skills propias de cada proyecto:** además de las de la base, cada proyecto puede crear las suyas (monitoreos, reportes, despliegues, rutinas de su dominio). La inicialización y las tareas normales pueden proponerlas.

## Consecuencias

- `CONSTITUTION.md` cambia en `§1` (lectura condicional y respaldo de skills), `§3` (remite a la skill de decisiones) y `§7` (agrega skills a la taxonomía). Requiere aprobación humana explícita.
- `inicializacion.md` pasa a ser una skill; el prompt de inicialización se evalúa como parte de ella.
- `estudio.md`, `agentes.md` y `flujo.md` se reducen a sus reglas, y sus procedimientos pasan a skills (`estudiar`, `decision`, `tarea`, `cerrar`).
- `clean-code.md` y `clean-architecture.md` quedan como referencia condicional.
- Al cambiar una regla, hay que revisar la skill que nombra, y al revés.
- La lectura de inicio debería bajar alrededor de un 40% (estimación sobre el conteo del 2026-10-15).

## Referencias

- [003] y [015] Separación standards vs adapters — la referencia condicional sigue el mismo criterio que los adapters
- [021] Skills como envoltorios de standards — superada parcialmente
- Especificación de Agent Skills: https://agentskills.io/specification (consultada 2026-10-15)
- Ubicación de skills por herramienta, consultada 2026-10-15: https://code.claude.com/docs/en/skills, https://learn.chatgpt.com/docs/build-skills, https://cursor.com/docs/context/skills, https://code.visualstudio.com/docs/copilot/customization/agent-skills, https://geminicli.com/docs/cli/skills/
- Tarea 0011 en `board.json`
