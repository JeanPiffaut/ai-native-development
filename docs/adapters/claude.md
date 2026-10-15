# Adapter: Claude Code (Orquestador)

- **Última actualización:** 2026-10-15
- **Frecuencia de cambio:** Baja — actualizar cuando cambie el modelo o la configuración del proyecto

---

## Cuándo leer este archivo

Leer este adapter cuando se trabaje específicamente con Claude Code como orquestador, o cuando se configure el entorno de trabajo con IA para este proyecto.

---

## Configuración actual

| Parámetro | Valor |
|---|---|
| Modelo | `claude-sonnet-4-6` |
| Modo | Interactivo (Claude Code CLI / extensión IDE) |
| Archivo de configuración | `.claude/settings.json` |

---

## Cómo se relaciona CONSTITUTION.md con Claude Code

Claude Code lee automáticamente el archivo `CLAUDE.md` en la raíz del proyecto al iniciar una sesión. En este framework ese rol lo cumple `docs/CONSTITUTION.md`.

Para que Claude Code cargue automáticamente la CONSTITUTION sin instrucción manual, crear un `CLAUDE.md` en la raíz que redirija:

```markdown
# CLAUDE.md

Lee `docs/CONSTITUTION.md` antes de cualquier acción y sigue sus instrucciones al pie de la letra.
```

---

## Permisos configurados

*Completar según la configuración en `.claude/settings.json`.*

Los permisos definen qué herramientas puede usar Claude sin pedir confirmación en cada llamada. Documentar aquí las decisiones tomadas sobre permisos para que queden trazables.

| Permiso | Estado | Motivo |
|---|---|---|
| Lectura de archivos | Permitido | Necesario para leer contexto |
| Escritura en `src/` | Permitido | Trabajo de implementación habitual |
| Escritura en `docs/` | Requiere confirmación | Modificaciones al framework requieren revisión |
| Ejecución de comandos | Según tarea | Confirmar antes de comandos destructivos |

---

## Hooks configurados

*Completar cuando se configuren hooks en `.claude/settings.json`.*

Los hooks permiten ejecutar comandos automáticamente antes o después de ciertas acciones del agente (ej. correr linting después de editar un archivo, o ejecutar tests después de un cambio en `src/`).

---

## Modelos disponibles y cuándo cambiar

| Modelo | Cuándo usarlo |
|---|---|
| `claude-sonnet-4-6` | Tareas de desarrollo habituales — balance entre velocidad y capacidad |
| `claude-opus-4-8` | Tareas de diseño complejo, revisión de arquitectura o análisis profundo |
| `claude-haiku-4-5` | Tareas simples y repetitivas donde la velocidad es prioritaria |

Si se cambia el modelo activo, actualizar la tabla de configuración al inicio de este archivo y registrar el motivo si la decisión es relevante.

---

## Archivos que Claude Code lee automáticamente

Claude Code carga automáticamente cualquier `CLAUDE.md` que encuentre en la raíz del proyecto o en directorios del workspace. El resto del contexto (`docs/`) se carga siguiendo las instrucciones de ese archivo.

También descubre las skills en `.claude/skills/<nombre>/SKILL.md` del directorio donde se inicia y de sus padres hasta la raíz del repositorio. Una skill guardada en cualquier otra carpeta (por ejemplo, dentro de `docs/`) no se descubre.

---

## Skills del proyecto

Viven en `.claude/skills/`, fuera de `docs/`, y viajan a la rama `template` con `scripts/sync-template.sh`.

| Skill | Qué hace | Quién la invoca | Se apoya en |
|---|---|---|---|
| `/iniciar` | Inicia la sesión y declara contexto leído, estado y tarea propuesta | Humano | `CONSTITUTION.md §1` |
| `/tarea <id>` | Analiza la tarea completa para trabajarla en conjunto; prepara la rama solo con acuerdo | Humano | `standards/flujo.md`, `standards/calidad.md` |
| `/cerrar` | Cierra la sesión: documentación al día, borradores para que el humano los cierre, board actualizado | Humano | `CONSTITUTION.md §6` |
| `estudiar` | Crea o amplía una ficha de estudio con fuentes verificadas | Humano o modelo, solo a pedido del humano | `standards/estudio.md` |
| `inicializar` | Adapta el framework al proyecto la primera vez; al terminar propone eliminarse | Modelo, con `meta.inicializado: false` | `CONSTITUTION.md §1` |
| `decision` | Registra decisiones como BORRADOR y las confirma con aprobación humana | Modelo | `CONSTITUTION.md §3` |
| `board` | Crea, actualiza y completa tareas según el esquema del board | Modelo | `standards/agentes.md` ("Board") |

Hay dos clases de skills:
- **Envoltorios** (`iniciar`, `tarea`, `cerrar`): ordenan pasos y fijan formatos de salida; las reglas viven en `CONSTITUTION.md` y `standards/`
- **Procedimientos** (`inicializar`, `decision`, `board`, `estudiar`): son la fuente de los pasos; la regla que los exige queda en `CONSTITUTION.md` o `standards/` y nombra la skill

Reglas para crear o modificar skills:
- **Las reglas no viven en skills** — lo que deba aplicar siempre va en `CONSTITUTION.md` o en un standard de lectura `siempre`, que nombra la skill a seguir. Una skill puede no cargarse; una regla siempre se lee
- **Invocación** — los envoltorios de sesión llevan `disable-model-invocation: true`: los dispara el humano. Los procedimientos los invoca el modelo; su `description` dice cuándo aplican. Si responden a un pedido del humano (como `estudiar`), la `description` lo restringe a ese pedido
- **Formato** — `name` igual al nombre de la carpeta, en minúsculas y guiones; `description` con qué hace y cuándo usarla (spec de agentskills.io)
- **Rutas desde la raíz** — las skills referencian `docs/...` porque se ejecutan desde la raíz del repositorio; sus archivos de apoyo, con rutas relativas a la skill (ej. `assets/`)
- **Sin referencias a decisiones** — las skills de la base son genéricas y viajan a `template`
- **Skills propias del proyecto** — cada proyecto puede crear las suyas (monitoreos, reportes, despliegues); se proponen en la inicialización o como tareas normales

Otros orquestadores: `SKILL.md` es un formato abierto (agentskills.io) que leen varias herramientas, aunque cada una busca en su carpeta (`.agents/skills`, `.cursor/skills`, `.github/skills`…). Si el orquestador no carga `.claude/skills`, la CONSTITUTION indica leer el `SKILL.md` directamente.

---

## Lo que este adapter no cubre

- Configuración de MCP servers → documentar en adapter específico si se agregan
- Uso de otros orquestadores (Cursor, Copilot, etc.) → crear su propio adapter siguiendo este como referencia
