# Estudio

- **Última actualización:** 2026-10-15
- **Lectura:** siempre

---

## Propósito

Trabajar con agentes de IA puede convertir el proyecto en una caja negra para el humano: el trabajo avanza, pero el entendimiento de las tecnologías, términos y técnicas que se usan se queda atrás.

Este estándar define cómo el humano pide material de estudio sobre los conceptos que aparecen en el trabajo, para entenderlos por su cuenta a partir de las mismas fuentes que usa el agente. No es un tutorial ni enseñanza paso a paso: es una guía de lectura con referencias verificadas.

Persigue dos cosas:

- **Contrastar, no confiar** — cuando el agente fundamenta una propuesta, el humano puede verificar ese fundamento contra la fuente primaria en lugar de aceptarlo por confianza
- **Conocimiento propio** — la documentación sostiene la memoria del proyecto; el entendimiento de las bases tiene que vivir en el humano

El estudio se guía solo por lo que el humano necesita entender en cada momento. No se planifica un temario: si con el tiempo las fichas acumuladas forman algo parecido a un plan de estudio del proyecto, es una consecuencia, no un objetivo.

---

## Cuándo se crea una ficha

**A pedido del humano.** Cuando no entiende un concepto que aparece en el trabajo, pide una ficha. El agente la crea o, si ya existe, la amplía.

El agente puede **sugerir** una ficha cuando introduce un concepto central para la tarea que no tiene ficha, en una línea y sin crearla. El humano decide si la quiere. Así `estudio/` contiene solo lo que el humano decidió estudiar.

---

## Dónde viven

Una ficha por concepto en `estudio/<concepto-en-kebab-case>.md`. Una ficha explica un concepto y guía su lectura; no es un tutorial, ni una bitácora de tareas, ni un registro de por qué se decidió algo (eso vive en `decisions/`). Los pasos para crearla o ampliarla — fuentes, índice y preguntas de comprensión — están en la skill `estudiar`.

---

## Fuera del contexto de trabajo

`estudio/` es material para el humano, no contexto para el agente. No es fuente de verdad y no orienta cómo se trabaja: para eso están `knowledge/`, `decisions/`, `standards/` y `adapters/`.

- No se lee en el protocolo de inicio de sesión ni durante la inicialización
- No se usa como contexto para tareas, propuestas ni decisiones, aunque una ficha trate el tema en cuestión
- El agente solo abre la ficha concreta que el humano pidió crear, ampliar o revisar
- Para saber si un concepto ya tiene ficha, basta con ver los nombres de archivo o `estudio/INDEX.md`, sin leer el contenido de las fichas

---

## Lo que este estándar no hace

- No obliga a crear fichas en cada tarea
- No reemplaza el registro de decisiones ni el glosario de `knowledge/dominio.md` (términos del negocio, no de las herramientas)
- No decide qué debe estudiar el humano — solo responde a lo que pide

---

## Historial de cambios

- **2026-10-15** — Encabezado: agregado el campo `Lectura` (siempre).
- **2026-10-15** — Se reduce a sus reglas: "Dónde viven" resumido; "Ruta de estudio", "Qué es y qué no es una ficha", "Reglas sobre las fuentes" y "Preguntas de comprensión" pasan a la skill `estudiar`.
