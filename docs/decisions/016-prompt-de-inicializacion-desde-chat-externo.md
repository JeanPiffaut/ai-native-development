# [016] Prompt de extracción de idea para apps externas como template

- **Estado:** BORRADOR
- **Fecha:** 2026-07-29
- **Supera a:** *(ninguna)*
- **Superada por:** *(ninguna)*

---

## Contexto

El usuario valida ideas de proyectos nuevos conversando con aplicaciones
completamente aparte de este framework (ChatGPT, Gemini, Claude.ai u otras),
antes de decidir desarrollarlas sobre esta infraestructura. Esas apps no
tienen ni pueden tener noción de `CONSTITUTION.md`, `knowledge/` ni
`decisions/` — son herramientas separadas sin acceso a este repositorio.
Hasta ahora, `README.md` solo describía llenar `knowledge/` manualmente al
clonar el framework, partiendo de cero. No existía un mecanismo para cerrar
una conversación de ideación externa con un resumen ordenado y portable, que
después se pueda traer a este framework sin perder información.

## Alternativas consideradas

### Opción A — Instrucción suelta, sin documentarla
Redactar un prompt ad-hoc cada vez que se necesite, sin dejarlo como artefacto
reutilizable. Más rápido una vez, pero se pierde entre sesiones y no es
consistente ni mejorable con el tiempo — contradice el principio "archivos
sobre memoria" (`knowledge/principios.md`).

### Opción B — Prompt genérico, agnóstico al framework, en docs/templates/ (elegida)
Crear `docs/templates/prompt-inicializacion.md` con un prompt de cierre
pensado para pegarse tal cual en la app externa. El prompt no menciona nada
de este repo — ni CONSTITUTION, ni knowledge/, ni decisions/ — porque la app
que lo recibe no tiene forma de actuar sobre esa información. Solo pide una
síntesis ordenada de la idea (qué es, problema, usuario, alcance, glosario,
decisiones tomadas con alternativas descartadas, preguntas abiertas, próximos
pasos) en vocabulario común. El mapeo de esa síntesis a `knowledge/` y
`decisions/` ocurre después, ya en este framework, usando el protocolo normal
de `CONSTITUTION.md` — no requiere un segundo prompt especializado.

### Opción C — Prompt que asume o enseña la estructura del framework a la app externa
Incluir en el prompt instrucciones sobre `knowledge/`, `decisions/`, formato
de ADR, etc., para que la app externa entregue el resultado ya pre-mapeado a
nuestra estructura de archivos. Se descartó: la app externa no tiene el
archivo `CONSTITUTION.md` ni el resto del contexto para aplicar esas reglas
correctamente, y pedirle que las siga "a ciegas" produce resultados
inconsistentes o inventados. Es más confiable pedir una síntesis genérica y
dejar el mapeo a un agente que sí tiene el contexto completo del framework.

### Opción D — Nueva carpeta docs/prompts/
Tratar los prompts ejecutables como categoría distinta de los templates de
relleno manual. Se descartó por ahora: con un solo documento de este tipo no
se justifica una nueva categoría en la taxonomía; si aparecen más prompts de
este estilo, se puede reconsiderar.

## Decisión

Se crea `docs/templates/prompt-inicializacion.md` como template de tipo B:
un prompt genérico y autocontenido, sin ninguna referencia a este framework,
para pegar en la app externa al cierre de una conversación de ideación. El
resultado (un resumen ordenado de la idea) se trae después a este repo y se
entrega a un agente que sí sigue `CONSTITUTION.md`, quien lo usa como base
para completar `docs/knowledge/` y proponer borradores en `docs/decisions/`
según el protocolo ya existente — sin necesidad de un prompt de importación
especializado.

## Consecuencias

- `docs/templates/` gana un tipo de template distinto a los existentes (es un
  prompt para pegar en una herramienta externa, no un formulario para
  completar a mano ni una instrucción para un agente de este repo) — se
  documenta la distinción dentro del propio archivo, no se crea una carpeta
  nueva
- El prompt debe mantenerse deliberadamente genérico: si en el futuro se le
  agrega vocabulario específico de este framework, deja de funcionar bien en
  apps externas sin contexto — cualquier cambio debe revisarse contra este
  criterio
- Si en el futuro se necesitan varios prompts de este estilo, esta decisión
  es la referencia para reconsiderar la Opción D (carpeta `docs/prompts/`)
- No cambia el protocolo de aprobación humana existente: las decisiones que
  el agente proponga al importar el resumen siguen naciendo como BORRADOR

## Referencias

Relacionado conceptualmente con [006] (sin templates para board y adapters)
como precedente de decisiones sobre qué entra o no en `templates/`.
