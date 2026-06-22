# [003] Separación entre standards/ y adapters/

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al diseñar dónde documentar Clean Code, Clean Architecture y convenciones de herramientas como Jest o NestJS, surgió la necesidad de distinguir dos tipos de documentación con ciclos de vida distintos.

## Alternativas consideradas

### Opción A — Todo en standards/
Un único directorio para principios metodológicos y convenciones de herramientas.
- Pro: estructura más simple.
- Contra: mezcla lo que aplica siempre con lo que depende del stack. Un proyecto sin NestJS cargaría convenciones que no le aplican.

### Opción B — Separación standards/ y adapters/ (elegida)
`standards/` para principios que aplican independientemente de la tecnología. `adapters/` para convenciones de herramientas o tecnologías específicas.
- Pro: el agente sabe qué leer siempre (standards/) y qué leer según el stack (adapters/).
- Contra: requiere que quien agrega documentación entienda la distinción.

## Decisión

**Regla de distinción:** si la convención aplica en cualquier proyecto sin importar el stack → `standards/`. Si solo aplica cuando se usa una herramienta concreta → `adapters/`.

Ambos directorios son aditivos: agregar algo nuevo siempre es crear un archivo, nunca editar los existentes.

## Consecuencias

- `standards/` contiene: flujo, convenciones, calidad, agentes, clean-code, clean-architecture
- `adapters/` contiene: jest, nestjs, typescript, docker, env-config, sonarqube, claude
- La taxonomía queda documentada en `CONSTITUTION.md §7` para que el agente pueda decidir dónde poner archivos nuevos
