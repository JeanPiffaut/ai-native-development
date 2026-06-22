# CONSTITUTION

Este archivo define el contrato operativo para cualquier agente de IA que trabaje en este proyecto.
Es el primer archivo que debes leer. No puede ser modificado por un agente sin aprobación humana explícita.

---

## 1. Protocolo de inicio de sesión

Al comenzar cualquier sesión, el agente DEBE leer en este orden:

1. `CONSTITUTION.md` (este archivo)
2. `knowledge/negocio.md`
3. `knowledge/dominio.md`
4. `knowledge/principios.md`
5. `board.json` — para entender el estado actual del trabajo
6. Las últimas 3 entradas en `decisions/` — para entender decisiones recientes
7. Todos los archivos en `standards/` — cada archivo es un estándar independiente; leerlos todos
8. El adapter relevante en `adapters/` según la tarea a realizar

Si alguno de estos archivos no existe todavía, continuar sin él e informar al usuario.

Al inicio de sesión, el agente DEBE declarar:
- Qué archivos leyó como contexto
- Cuál es su entendimiento del estado actual del proyecto (basado en board.json)
- Qué tarea va a abordar

---

## 2. Matriz de permisos

### El agente puede hacer sin pedir aprobación:
- Leer cualquier archivo del proyecto
- Crear nuevas entradas en `decisions/` (propuestas, marcadas como BORRADOR)
- Actualizar `board.json`
- Crear o modificar archivos dentro de `src/`
- Crear o modificar archivos en `adapters/`
- Proponer cambios a `standards/` o `knowledge/`

### El agente DEBE pedir aprobación antes de:
- Modificar `CONSTITUTION.md`
- Modificar archivos existentes en `knowledge/`
- Confirmar una decisión en `decisions/` (cambiar estado de BORRADOR a CONFIRMADA)
- Eliminar cualquier archivo
- Renombrar o mover archivos fuera de `src/`
- Modificar `standards/` directamente (debe proponer y esperar confirmación)

### Nunca permitido:
- Editar o eliminar decisiones ya confirmadas en `decisions/`
- Alterar el historial de decisiones
- Ignorar una decisión confirmada sin crear una nueva que la supere explícitamente

---

## 3. Registro de decisiones

Una decisión debe registrarse cuando:
- Se elige una tecnología, librería o herramienta
- Se define una estructura de datos o arquitectura
- Se establece una convención que otros deberán seguir
- Se descarta una alternativa que podría parecer obvia
- Se resuelve un conflicto entre dos enfoques válidos

Cuando corresponda registrar una decisión, el agente debe:
1. Crear un borrador usando `templates/decision.md`
2. Nombrar el archivo: `NNN-titulo-en-kebab-case.md` (número correlativo)
3. Marcar el estado como `BORRADOR`
4. Informar al usuario y pedir confirmación antes de marcarlo como `CONFIRMADA`

Las decisiones confirmadas son append-only: nunca se editan.
Si una decisión cambia, se crea una nueva que referencia la anterior con `supera-a: NNN`.

---

## 4. Gestión del board

`board.json` es el estado vivo del trabajo. El agente debe:

- Consultar `board.json` al inicio de cada sesión para entender el contexto
- Actualizar el estado de las tareas trabajadas al finalizar la sesión
- Proponer nuevas tareas al board cuando las descubra durante el trabajo
- No eliminar tareas completadas — cambiar su estado a `completada`

---

## 5. Reglas de comunicación

- Si la tarea a realizar no está en `board.json`, preguntar antes de empezar
- Si hay ambigüedad sobre el alcance de una tarea, preguntar antes de implementar
- Si se descubre deuda técnica o un problema no relacionado con la tarea actual, agregarlo al board y continuar con la tarea original
- Si una decisión confirmada entra en conflicto con la tarea solicitada, señalarlo explícitamente antes de proceder
- Preferir preguntas cortas y concretas sobre suposiciones silenciosas

---

## 6. Cierre de sesión

Al finalizar una sesión, el agente DEBE:
1. Actualizar `board.json` con el estado real de las tareas trabajadas
2. Si se tomaron decisiones relevantes, confirmar que están registradas en `decisions/`
3. Listar brevemente qué se hizo y qué quedó pendiente

---

## 7. Taxonomía de directorios

Cuando debas decidir dónde vive un archivo nuevo, aplicar esta distinción:

| Directorio | Qué contiene | Criterio para agregar algo aquí |
|---|---|---|
| `knowledge/` | Contexto del negocio o proyecto | Es información sobre *qué* es el proyecto y *para quién* |
| `decisions/` | Registro de decisiones tomadas | Se tomó una decisión relevante que debe quedar trazable |
| `standards/` | Principios y metodologías de trabajo | Aplica **independientemente** de la tecnología o herramienta usada |
| `adapters/` | Convenciones de una herramienta o tecnología específica | Solo aplica si el proyecto **usa esa herramienta**; otro proyecto podría no usarla |
| `templates/` | Plantillas reutilizables | Es un molde que se reutiliza para crear otros documentos |

**Regla de distinción clave — standards vs adapters:**
Si la convención aplica igual en un proyecto React que en uno de NestJS que en uno sin código → va en `standards/`.
Si la convención solo tiene sentido cuando usas una tecnología concreta → va en `adapters/`.

Ambos directorios son aditivos: agregar un nuevo estándar o adapter es crear un archivo nuevo, nunca editar los existentes.

---

## 8. Jerarquía de fuentes de verdad

En caso de conflicto entre fuentes, aplicar en este orden:

1. `CONSTITUTION.md` — máxima autoridad
2. `decisions/` confirmadas — historial de por qué
3. `standards/` — cómo se trabaja
4. `knowledge/` — contexto de negocio
5. `adapters/` — especificidades de la herramienta
6. El código en `src/` — estado actual de implementación

---

*Versión: 1.0 — Este archivo solo puede ser modificado con aprobación humana explícita.*
