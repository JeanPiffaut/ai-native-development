# Agentes

- **Última actualización:** 2026-06-22

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

## Cómo proponer una decisión

```
1. Detectar que se va a tomar una decisión relevante
2. Crear borrador en decisions/ usando templates/decision.md
3. Nombrar: NNN-titulo-en-kebab-case.md (estado: BORRADOR)
4. Presentar al usuario con las alternativas evaluadas
5. Esperar confirmación antes de marcar como CONFIRMADA
6. Implementar según la decisión confirmada
```

---

## Cómo actualizar el board

El board refleja únicamente el trabajo activo. Las tareas completadas se eliminan; las que tienen `decision_relacionada` se registran en `meta.historial` antes de eliminarlas.

Reglas:
- Los IDs son numéricos de 4 dígitos con ceros a la izquierda: `0001`, `0002`, `0003`... Únicos y nunca reutilizados, aunque la tarea se haya eliminado
- Al crear una tarea nueva, tomar `meta.ultimo_id`, incrementar en 1, y actualizar el campo
- Al completar una tarea: si tiene `decision_relacionada`, agregar entrada a `meta.historial`; luego eliminar la tarea de `tareas`
- Git es operación humana — el agente nunca ejecuta git aunque el board lo indique
- `contexto` es estático — describe por qué existe la tarea y no cambia
- `notas` es dinámico — array de strings donde el agente y el humano agregan entradas relevantes durante el trabajo (motivo de bloqueo, descubrimientos, cambios de alcance, etc.). Cada entrada es un string independiente.

```json
{
  "id": "0001",
  "titulo": "Descripción corta de la tarea",
  "tipo": "feature | bug | deuda | investigacion | proceso | recurrente",
  "cadencia": "mensual | trimestral | semestral | anual",
  "estado": "pendiente | haciendo | bloqueado",
  "prioridad": "alta | media | baja",
  "contexto": "Por qué existe esta tarea. Qué la originó. No cambia.",
  "notas": [],
  "decision_relacionada": "NNN o null",
  "creada": "YYYY-MM-DD"
}
```

La sección `meta` vive al final del JSON, después de `tareas`:

```json
"meta": {
  "ultimo_id": "0001",
  "historial": [
    {
      "id": "0001",
      "titulo": "Descripción corta de la tarea",
      "completada": "YYYY-MM-DD",
      "decision_relacionada": "NNN"
    }
  ]
}
```

## Tareas recurrentes

Las tareas con `tipo: recurrente` representan trabajo periódico que debe repetirse. Incluyen el campo `cadencia` para indicar la frecuencia.

Al completar una tarea recurrente, el agente **debe**:
1. Si la tarea tiene `decision_relacionada`, agregar entrada a `meta.historial`
2. Crear una nueva instancia de la tarea con `creada` actualizada a la fecha actual
3. Eliminar la tarea completada del board

Si no se re-crea la tarea, el ciclo se rompe y la recurrencia se pierde. La re-creación es responsabilidad del agente que completa la tarea.

El campo `cadencia` no es obligatorio en tareas de otros tipos. En tareas recurrentes, es obligatorio.

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
- Ejecutar operaciones git de ningún tipo — git es responsabilidad humana exclusiva
- Tomar decisiones de arquitectura sin registrarlas
- Modificar `CONSTITUTION.md` o decisiones confirmadas
- Asumir que algo "no importa" sin verificarlo en `knowledge/principios.md`
- Resolver ambigüedades silenciosamente cuando afectan el diseño
- Asumir versiones de herramientas sin verificar — ver sección anterior

**Sobre git:** el agente puede sugerir qué commitear, con qué mensaje y en qué rama, pero nunca ejecutar los comandos. La revisión humana antes del commit es una garantía deliberada del proceso.

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
