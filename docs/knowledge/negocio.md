# Negocio

- **Última actualización:** 2026-09-28

---

## ¿Qué es este proyecto?

AI-Native Development Framework es una plantilla de repositorio para trabajar con agentes de IA de forma estructurada, trazable y consistente. Define la documentación base que cualquier agente necesita para entender un proyecto, comportarse de forma predecible y retomar el trabajo entre sesiones sin perder contexto. Es agnóstico al modelo de lenguaje y al orquestador.

## Problema que resuelve

Trabajar con agentes de IA sin estructura produce tres problemas recurrentes:
- **Pérdida de contexto entre sesiones** — el agente comienza desde cero cada vez y el usuario debe re-explicar el proyecto
- **Decisiones no trazables** — nadie sabe por qué se tomó una decisión técnica semanas después
- **Comportamiento inconsistente** — sin reglas explícitas, cada sesión puede producir resultados que rompen estándares anteriores

## Usuario principal

Desarrolladores o equipos pequeños que usan agentes de IA como parte activa del desarrollo y quieren continuidad, trazabilidad y estándares consistentes entre sesiones y entre distintos modelos.

## Modelo de valor

La rama `template` se lleva a la raíz de un proyecto, nuevo o existente, de software o de cualquier otra naturaleza (documentación, investigación, datos, operación, contenido). En la primera sesión el agente detecta que el proyecto no está inicializado y sigue `standards/inicializacion.md`: diagnostica el proyecto y, con aprobación humana, adapta knowledge, standards, adapters, templates y flujos a lo que ese proyecto necesita. Desde ahí, el agente lee `CLAUDE.md` al iniciar → carga `docs/CONSTITUTION.md` → sigue el protocolo de lectura → trabaja con contexto completo sin instrucciones adicionales del usuario.

## Estado actual

Framework base funcional con CONSTITUTION, standards, adapters y templates. `main` es donde se trabaja el framework; `template` es la base limpia que se lleva a otros proyectos. En lugar de variantes de template por tipo de proyecto, cada proyecto se adapta con el flujo de inicialización ([018]).

## Métricas de éxito

- Un agente nuevo retoma una sesión leyendo solo los archivos de `docs/`, sin instrucciones adicionales
- Todas las decisiones técnicas tienen trazabilidad en `decisions/`
- El framework es usado como base en al menos un proyecto real sin necesidad de modificar su estructura

## Lo que NO es este proyecto

- No es una herramienta de IA ni un modelo de lenguaje
- No es un framework de código (no reemplaza NestJS, React u otros)
- No está atado a ningún orquestador, modelo ni lenguaje de programación
- No es una plataforma de documentación — es una convención de estructura de archivos

---

## Historial de cambios

- **2026-09-28** — Modelo de valor y estado actual: el framework se lleva desde la rama `template` y se adapta a cada proyecto (no solo software) mediante el flujo de inicialización; se descarta el plan de variantes de template. Según [018].
