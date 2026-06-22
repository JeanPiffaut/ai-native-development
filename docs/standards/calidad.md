# Calidad

- **Última actualización:** 2026-06-22

---

## Criterios mínimos de entrega

Toda tarea completada debe cumplir:

- [ ] El resultado hace lo que el criterio de aceptación dice
- [ ] No rompe convenciones ni decisiones documentadas en `decisions/` o `knowledge/`
- [ ] Sigue las convenciones de `standards/convenciones.md`
- [ ] Si se tomó una decisión relevante durante el trabajo, está registrada en `decisions/`
- [ ] La tarea fue registrada en `meta.historial` y eliminada de `tareas` en `board.json`

## Criterios de aceptación

Los criterios de aceptación de cada tarea deben definirse antes de empezar.
Si una tarea en `board.json` no los tiene, el agente debe pedirlos antes de proceder.
Una vez acordados, el agente los registra como primera entrada en el campo `notas` de la tarea.
Si aplica un adapter en `adapters/`, los criterios específicos de esa herramienta o tecnología están allí.

## Qué hacer ante deuda de calidad

Si se detecta que algo existente no cumple los criterios mínimos:
1. Agregar a `board.json` con tipo `deuda` y prioridad correspondiente
2. No corregirlo en la misma sesión salvo que sea trivial o bloqueante
3. No ignorarlo silenciosamente

## Revisión de decisiones históricas

Antes de implementar algo que parezca contradecir una decisión confirmada:
1. Verificar en `decisions/` si existe una decisión que aplique
2. Si existe: señalarlo al usuario y proponer una nueva decisión antes de proceder
3. Si no existe: proceder y registrar la decisión tomada

---

## Historial de cambios

- **2026-06-22** — Checklist de entrega: "estado actualizado" → "registrada en meta.historial y eliminada de tareas". Criterios de aceptación: se documenta que se registran como primera entrada en `notas` de la tarea.
