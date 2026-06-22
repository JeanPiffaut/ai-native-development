# Convenciones

- **Última actualización:** 2026-06-22

---

## Nomenclatura de archivos

| Tipo | Convención | Ejemplo |
|---|---|---|
| Decisiones | `NNN-titulo-en-kebab-case.md` | `003-eleccion-base-de-datos.md` |
| Knowledge | `nombre-descriptivo.md` | `negocio.md`, `dominio.md` |
| Adapters | `nombre-tecnologia.md` | `nestjs.md`, `react.md` |
| Templates | `nombre-del-template.md` | `decision.md` |
| Tareas en board | ID correlativo con prefijo | `T-001`, `T-002` |

## Numeración de decisiones

- Correlativa y sin saltos: `001`, `002`, `003`...
- Si una decisión se descarta antes de confirmarse, el número queda reservado (no reutilizar)
- El número no tiene relación con importancia, solo con orden cronológico

## Lenguaje

- Documentación: español
- Código fuente: inglés (nombres de variables, funciones, clases, comentarios en código)
- Nombres de carpetas y archivos del framework: español (knowledge, decisions, standards...)
- Nombres de carpetas y archivos del proyecto técnico (`src/`): según adapter correspondiente

## Formato de fechas

- Siempre ISO 8601: `YYYY-MM-DD`
- Nunca formatos ambiguos como `22/06/26` o `Jun 22`

## Estructura de un archivo de knowledge

Todo archivo en `knowledge/` debe comenzar con:
```
# Título
- **Última actualización:** YYYY-MM-DD
---
```

## Estructura de board.json

Ver esquema definido en el propio `board.json`.
Los campos `id`, `titulo`, `estado` y `tipo` son obligatorios en toda tarea.

## Versionado de standards

Cuando un archivo en `standards/` cambia de forma significativa:
- Registrar la razón del cambio al final del archivo bajo `## Historial de cambios`
- Si el cambio implica una decisión de diseño, crear ADR correspondiente
