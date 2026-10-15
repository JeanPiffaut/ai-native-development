---
name: estudiar
description: Crea o amplía una ficha de estudio en docs/estudio/ con fuentes primarias verificadas y preguntas de comprensión, según docs/standards/estudio.md. Usar solo cuando el humano pide entender un concepto ("no entiendo X", "explícame X", "quiero estudiar X"). No usar por iniciativa propia al detectar un concepto nuevo; en ese caso, solo sugerir la ficha en una línea.
argument-hint: "[tema]"
---

Tema a estudiar: $ARGUMENTS

Si no se indicó un tema, pregunta cuál. Sigue `docs/standards/estudio.md`; esta skill solo ordena los pasos.

1. **¿Ya hay ficha?** Revisa los nombres de archivo en `docs/estudio/` y `docs/estudio/INDEX.md`. No abras otras fichas. Si una cubre el tema, ábrela para ampliarla en lugar de crear otra.
2. **Fuentes.** Busca en la web fuentes primarias sobre el tema (documentación oficial, especificaciones, RFC, papers). Incluye solo las que consultaste de verdad, con la sección a leer y la fecha de consulta.
3. **Ficha.** Créala con `docs/templates/estudio.md` como `docs/estudio/<concepto-en-kebab-case>.md`, o amplía la existente y registra el cambio en su historial. En "Cómo lo usamos aquí", enlaza decisiones o archivos del proyecto sin repetir su razonamiento.
4. **Índice.** Ubica la ficha en `docs/estudio/INDEX.md` según su nivel y sus prerequisitos. Si el índice no existe, créalo.
5. **Entrega.** Indica la ruta de la ficha, el orden de lectura sugerido y las preguntas de comprensión. Ofrece revisar sus respuestas o su explicación contra las fuentes.
