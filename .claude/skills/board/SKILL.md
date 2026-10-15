---
name: board
description: Crea, actualiza o completa tareas en docs/board.json siguiendo su esquema — IDs, estados, notas, historial y recreación de tareas recurrentes. Usar siempre que se agregue una tarea, cambie su estado o se complete.
---

Las reglas del board están en `docs/standards/agentes.md` ("Board"). Esta skill tiene el esquema y los pasos.

## Esquema

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

- Obligatorios: `id`, `titulo`, `estado`, `tipo`
- `cadencia` solo en tareas `recurrente`, donde es obligatoria
- `contexto` es estático; `notas` es un array de strings donde agente y humano agregan lo relevante durante el trabajo (criterios de aceptación como primera entrada, bloqueos, descubrimientos, cambios de alcance)

La sección `meta` va al final del JSON, después de `tareas`:

```json
"meta": {
  "inicializado": true,
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

`inicializado` vale `false` en la rama `template`; mientras sea `false` se sigue la skill `inicializar`.

## Crear una tarea

1. Verificar que es autoconclusiva (`docs/standards/agentes.md`); si no, dividirla.
2. `id` = `meta.ultimo_id` + 1, con cuatro dígitos. Actualizar `meta.ultimo_id`.
3. Estado inicial `pendiente`, `creada` con la fecha de hoy.

## Actualizar una tarea

- Al empezarla: `estado: haciendo`, en su propia rama (`docs/standards/flujo.md`)
- Bloqueo: `estado: bloqueado` y el motivo en `notas`
- Los cambios propios de una tarea se hacen en su rama y llegan a `main` con el merge humano

## Completar una tarea

Solo cuando cumple sus criterios de aceptación (`docs/standards/calidad.md`) y el humano lo confirma.

1. Si tiene `decision_relacionada`, agregar la entrada a `meta.historial` (en historial ese campo nunca es `null`).
2. Si es `recurrente`, crear una nueva instancia con nuevo `id` y `creada` con la fecha de hoy. Si no se recrea, la recurrencia se pierde.
3. Eliminarla de `tareas`. Las tareas completadas no tienen estado: se eliminan.
4. Hacerlo en la rama de la tarea, antes del commit, para que el cierre viaje en el mismo merge.
