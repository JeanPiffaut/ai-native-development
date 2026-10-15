# Agentes

- **Última actualización:** 2026-10-15
- **Lectura:** siempre

---

## Principios de comportamiento

Los agentes que trabajen en este proyecto deben operar bajo estos principios:

1. **Contexto antes de acción** — Leer antes de hacer. Nunca asumir el estado del proyecto.
2. **Transparencia sobre suposiciones** — Si algo no está documentado, declararlo como suposición y pedir confirmación.
3. **Alcance mínimo** — Hacer exactamente lo pedido. No refactorizar ni ampliar scope sin aprobación.
4. **Registro de decisiones** — Toda decisión relevante debe quedar documentada, no solo implementada.
5. **Preguntar es preferible a suponer** — Una pregunta concreta cuesta menos que deshacer trabajo mal dirigido.

---

## Protocolo de inicio

Ver `CONSTITUTION.md §1` — es la única fuente de verdad para el orden de lectura al iniciar sesión. No se duplica aquí para evitar divergencias.

---

## Decisiones

Toda decisión relevante se registra como `BORRADOR` y se implementa una vez confirmada por el humano (`CONSTITUTION.md §3`). Los pasos están en la skill `decision`.

---

## Board

El board refleja únicamente el trabajo activo. Reglas:
- Los IDs son numéricos de 4 dígitos (`0001`, `0002`…), únicos y nunca reutilizados, aunque la tarea se haya eliminado
- Las tareas completadas se eliminan; solo las que tienen `decision_relacionada` se registran antes en `meta.historial`
- Las tareas `recurrente` llevan `cadencia` y, al completarse, se recrean; si no, la recurrencia se pierde
- `contexto` es estático; `notas` registra lo que surge durante el trabajo
- Los cambios al board propios de una tarea se hacen en su rama y llegan a `main` con el merge humano
- `meta.inicializado` en `false` indica que el proyecto no pasó por la inicialización

El esquema y los pasos para crear, actualizar y completar tareas están en la skill `board`.

---

## Definición de tareas

Toda tarea debe ser autoconclusiva: al completarse debe entregar algo funcional y en estado usable. Una tarea que deja el sistema en un estado intermedio o roto no es una tarea válida — debe dividirse o replantearse.

Antes de agregar una tarea al board, verificar:
- ¿Qué entrega exactamente cuando esté lista?
- ¿El proyecto funciona correctamente después de completarla?
- Si la respuesta a alguna de las dos es ambigua, dividir en tareas más pequeñas que sí la cumplan

Ejemplos:
- ❌ "Implementar módulo de autenticación" — demasiado amplio, no define qué entrega
- ✅ "Implementar endpoint POST /auth/login con JWT" — entrega algo concreto y funcional
- ❌ "Migrar base de datos" — puede dejar el sistema roto si no se completa todo
- ✅ "Agregar migración para tabla users y verificar que la app levanta con ella aplicada"

---

## Versiones y conocimiento externo

El conocimiento de entrenamiento de un modelo tiene fecha de corte y las versiones quedan obsoletas rápidamente.

**Regla:** ante cualquier tarea que requiera definir o usar una versión específica de una herramienta, runtime, librería o imagen base, el agente debe buscar en la web la versión estable o LTS actual antes de proponer o escribir código.

Esto aplica a:
- Imágenes base de Docker (`node:24-alpine`, `postgres:16`, etc.)
- Versiones de dependencias en `package.json`
- Versiones de herramientas de CI o infraestructura
- Cualquier versión que aparezca en archivos de configuración

No aplica cuando:
- La versión está explícitamente fijada en `adapters/` o en archivos del proyecto — usar esa versión sin cambiarla
- El usuario indica la versión a usar — seguir su instrucción

---

## Límites del agente

El agente no debe:
- Ejecutar operaciones git fuera de las permitidas (ver "Sobre git" más abajo)
- Tomar decisiones de arquitectura sin registrarlas
- Modificar `CONSTITUTION.md` o decisiones confirmadas
- Asumir que algo "no importa" sin verificarlo en `knowledge/principios.md`
- Resolver ambigüedades silenciosamente cuando afectan el diseño
- Asumir versiones de herramientas sin verificar — ver sección anterior

**Sobre git:** el agente solo puede consultar estado (`status`, `branch`, `log`, `diff`), actualizar `main` (`checkout main` + `pull --ff-only`) y crear o cambiar a la rama de la tarea (`checkout -b` / `checkout`). Si hay cambios sin commitear o algo falla, se detiene y avisa. Commit, push, merge, rebase y cualquier otra operación son humanos: el agente sugiere qué commitear y con qué mensaje, pero no lo ejecuta. La revisión humana antes del commit y el merge a `main` es una garantía deliberada del proceso — `main` solo cambia por merges humanos.

---

## Compatibilidad con distintos modelos y orquestadores

Este framework es agnóstico. Los archivos son Markdown plano y JSON.
No hay dependencias de herramientas específicas.

Si el orquestador o modelo tiene convenciones propias (ej. archivos de configuración específicos como `.claude/`, `.cursor/`), pueden coexistir con este framework sin modificar su estructura.

---

## Historial de cambios

- **2026-06-22** — Eliminado resumen del protocolo de inicio; reemplazado por referencia directa a `CONSTITUTION.md §1` para evitar divergencias entre fuentes.
- **2026-06-22** — Regla de historial refinada: solo las tareas con `decision_relacionada` se registran en `meta.historial` al completarse. Tareas sin decisión vinculada se eliminan directamente. Aplica también a tareas recurrentes (paso agregado).
- **2026-06-22** — Párrafo introductorio de "Cómo actualizar el board" corregido: la frase incondicional "se registran en meta.historial" reemplazada por la versión condicional. Esquema JSON de historial: campo `decision_relacionada` corregido de "NNN o null" a "NNN" — en historial siempre es no-nulo por definición de [014].
- **2026-09-28** — Git: la prohibición total se reemplaza por las operaciones permitidas en [017] (actualizar `main`, crear/cambiar a la rama de la tarea). Regla del board: los cambios propios de una tarea viajan en su rama.
- **2026-09-28** — Esquema de `meta`: agregado `inicializado` (dispara el flujo de `standards/inicializacion.md` cuando es `false`). Según [018].
- **2026-09-28** — Límites del agente: la referencia a [017] se reemplaza por la sección "Sobre git", para que la regla sea autocontenida en proyectos donde `decisions/` no incluye la [017].
- **2026-10-15** — Encabezado: agregado el campo `Lectura` (siempre).
- **2026-10-15** — "Cómo proponer una decisión", "Cómo actualizar el board" y "Tareas recurrentes" se reducen a sus reglas (secciones "Decisiones" y "Board"); el esquema del board y los pasos pasan a las skills `decision` y `board`.
