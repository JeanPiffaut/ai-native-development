# [004] Usar ENVIRONMENT como variable de entorno genérica

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al definir el adapter de variables de entorno, la primera versión usaba `NODE_ENV` como variable estándar para el entorno de ejecución. El framework debe ser agnóstico al runtime, y `NODE_ENV` es una convención específica del ecosistema Node.js.

## Alternativas consideradas

### Opción A — NODE_ENV
Convención estándar en proyectos Node.js/npm.
- Pro: familiar para developers de JavaScript.
- Contra: ata semánticamente el framework a Node.js. Un proyecto Python, Go o sin código no usaría esta variable.

### Opción B — ENVIRONMENT (elegida)
Variable genérica que cualquier proyecto puede adoptar independientemente del lenguaje o runtime.
- Pro: agnóstico al stack, consistente con el principio del framework.
- Contra: no es la convención por defecto en proyectos Node — requiere configuración explícita si el framework lo espera.

## Decisión

Usar `ENVIRONMENT` como variable estándar de entorno en el framework. Los adapters específicos de tecnología pueden mapearlo a la convención del stack si es necesario (ej. NestJS puede leer `ENVIRONMENT` y exponerlo como `NODE_ENV` internamente).

## Consecuencias

- `adapters/env-config.md` usa `ENVIRONMENT` como variable base
- `PORT` siempre explícito en `.env`, sin valor por defecto en el código
- Los adapters de frameworks específicos (NestJS, etc.) documentan el mapeo si aplica
