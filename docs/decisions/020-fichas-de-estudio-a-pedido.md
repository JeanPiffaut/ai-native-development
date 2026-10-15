# [020] Fichas de estudio por concepto, a pedido del humano

- **Estado:** CONFIRMADA
- **Fecha:** 2026-10-15
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al delegar trabajo en agentes de IA, el humano corre el riesgo de quedar atrás: el proyecto avanza con tecnologías, términos y técnicas que no termina de entender, y se vuelve una caja negra. Eso también debilita el gate humano, porque no se puede aprobar con criterio algo que no se entiende.

El síntoma concreto: las soluciones que el humano aporta terminan siendo casi totalmente propuestas y fundamentadas por la IA, y la única forma de validarlas es confiar en ella. La documentación del framework sostiene la memoria del proyecto, pero el conocimiento de las bases tiene que vivir en el humano.

Se busca un mecanismo para que el humano estudie por su cuenta los conceptos que aparecen en el trabajo, apoyado en las mismas fuentes que usa el agente. No se busca que la IA enseñe paso a paso.

El mecanismo debe ser genérico (aplica a cualquier tipo de proyecto, no solo de software) y no debe duplicar lo que ya registran `decisions/` ni el glosario de `knowledge/dominio.md`.

## Alternativas consideradas

### Opción A — Ficha de estudio por tarea (bitácora)
- Pro: queda claro qué se vio en cada tarea.
- Contra: duplica el registro de decisiones y del board; el mismo concepto termina repartido en muchas fichas; mezcla "qué hicimos" con "qué necesito entender".

### Opción B — Ficha por concepto, generada en cada tarea
- Pro: cobertura completa; nada queda sin documentar.
- Contra: genera material que el humano no pidió y no va a leer; el estudio pierde foco y el costo por tarea sube sin necesidad.

### Opción C — Ficha por concepto, a pedido del humano (elegida)
- Pro: `estudio/` contiene solo lo que el humano decidió estudiar; una ficha por concepto que crece con el tiempo; no se cruza con decisiones ni con el board.
- Contra: depende de que el humano detecte qué no entiende. Se mitiga con que el agente puede sugerir una ficha cuando introduce un concepto central sin ficha, sin crearla.

## Decisión

- Nuevo directorio `docs/estudio/` con una ficha por concepto (`<concepto-en-kebab-case>.md`).
- Las fichas se crean o amplían a pedido del humano. El agente puede sugerirlas, pero no crearlas por su cuenta.
- Nuevo estándar `standards/estudio.md` con las reglas y nueva plantilla `templates/estudio.md`.
- Las fuentes son solo las consultadas de verdad, primarias primero, cada una con qué leer y fecha de consulta.
- `estudio/INDEX.md` ordena las fichas existentes en tres niveles (fundamentos → herramientas y técnicas → el proyecto), respetando los prerequisitos de cada ficha. No anticipa temas: el estudio lo guía lo que el humano necesita, y si con el tiempo se forma algo parecido a un plan de estudio del proyecto, es una consecuencia y no un objetivo.
- Cada ficha cierra con preguntas de comprensión en dos bloques, "sobre el concepto" y "en este proyecto", sin respuestas y en nivel creciente de exigencia (taxonomía de Bloom). El humano puede responder o explicar el concepto con sus palabras y el agente lo revisa contra las fuentes. El enfoque se ajustará con el uso.
- `estudio/` queda fuera del contexto de trabajo del agente: no se lee al iniciar sesión ni en la inicialización, no se usa como contexto para tareas ni decisiones y no entra en la jerarquía de fuentes de verdad. El agente solo abre la ficha que el humano pide. Así se evita gastar contexto en material que no es para el agente y que las fichas terminen sustituyendo a los standards que guían el trabajo.
- Si `estudio/` se versiona en git o no lo decide cada proyecto, igual que el resto de `docs/`.

## Consecuencias

- `CONSTITUTION.md §2` permite crear y modificar fichas en `estudio/` sin aprobación, y `§7` agrega `estudio/` a la taxonomía. Ambos cambios requieren aprobación humana explícita.
- `standards/estudio.md` y `templates/estudio.md` son genéricos y viajan a la rama `template` con la sincronización ([019]); las fichas de cada proyecto no.
- Armar una ficha cuesta tiempo de sesión. Se acepta: es el precio de que el proyecto no se vuelva una caja negra.

## Referencias

- [019] Sincronización de template por script — `standards/` y `templates/` ya están en la lista de genéricos
- `knowledge/dominio.md` — glosario del negocio, distinto de las fichas de estudio
- Tarea 0008 en `board.json`
