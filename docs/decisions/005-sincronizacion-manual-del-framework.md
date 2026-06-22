# [005] Gestión manual del framework base (sin git submodule)

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al pensar en cómo las mejoras descubiertas en proyectos concretos vuelven al framework base, surgió la opción de usar git submodules para que los proyectos reciban actualizaciones automáticamente.

## Alternativas consideradas

### Opción A — Git submodule
El framework base se incluye como submodule en cada proyecto. Los proyectos corren `git submodule update` para recibir mejoras.
- Pro: propagación automática de mejoras, un solo punto de verdad.
- Contra: requiere separar los archivos "base" de los archivos "del proyecto" dentro de `docs/`. Los submodules tienen fricción conocida (clones, actualizaciones, conflictos). La complejidad no está justificada para pocos proyectos.

### Opción B — Gestión manual (elegida)
El developer identifica mejoras en proyectos concretos y las lleva al repo base manualmente cuando decide que son generalizables.
- Pro: sin fricción técnica. El developer actúa como editor del framework. Simple de mantener con pocos proyectos.
- Contra: requiere disciplina. Las mejoras pueden perderse si no se transfieren.

## Decisión

Gestión manual. El developer es responsable de identificar y transferir mejoras del framework base. Cuando la cantidad de proyectos activos justifique la complejidad, se puede reevaluar con una nueva decisión.

## Consecuencias

- No hay dependencia técnica entre proyectos y el repo del framework
- La estructura de `docs/` no necesita distinguir archivos "base" de archivos "del proyecto"
- El developer revisa al final de cada proyecto qué aprendizajes deberían subir al framework base
