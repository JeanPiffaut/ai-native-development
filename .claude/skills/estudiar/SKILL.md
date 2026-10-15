---
name: estudiar
description: Crea o amplía una ficha de estudio en docs/estudio/ con fuentes primarias verificadas y preguntas de comprensión. Usar solo cuando el humano pide entender un concepto ("no entiendo X", "explícame X", "quiero estudiar X"). No usar por iniciativa propia al detectar un concepto nuevo; en ese caso, solo sugerir la ficha en una línea.
argument-hint: "[tema]"
---

Tema a estudiar: $ARGUMENTS

Si no se indicó un tema, pregunta cuál. Las reglas (a pedido del humano, fuera del contexto de trabajo) están en `docs/standards/estudio.md`. Esta skill tiene los pasos.

## 1. ¿Ya hay ficha?

Revisa los nombres de archivo en `docs/estudio/` y `docs/estudio/INDEX.md`. No abras otras fichas. Si una cubre el tema, ábrela para ampliarla en lugar de crear otra.

## 2. Fuentes

Busca en la web fuentes sobre el tema.
- **Solo fuentes consultadas de verdad** — nunca ligas inventadas ni reconstruidas de memoria
- **Primarias primero** — documentación oficial, especificaciones, RFC, papers o el código fuente antes que blogs o tutoriales de terceros
- **Cada fuente dice qué leer** — la sección concreta y por qué sirve
- **Fecha de consulta** en cada fuente

## 3. Ficha

Créala con `docs/templates/estudio.md` como `docs/estudio/<concepto-en-kebab-case>.md`, o amplía la existente y registra el cambio en su historial.

| Una ficha es | Una ficha no es |
|---|---|
| Explicación breve del concepto, con palabras propias | Una copia o resumen largo de la documentación |
| Una guía de qué leer, dónde y en qué orden | Un tutorial paso a paso |
| Un puente entre el concepto y su uso en este proyecto | Una bitácora de tareas |
| Un documento vivo que se amplía | Un registro de por qué se decidió algo — eso vive en `docs/decisions/` |

En "Cómo lo usamos aquí", enlaza decisiones o archivos del proyecto sin repetir su razonamiento.

**Preguntas de comprensión** — sin respuestas, de menor a mayor exigencia (taxonomía de Bloom: recordar y entender → aplicar, analizar y evaluar):
- **Sobre el concepto** — qué es, cómo funciona, qué problema resuelve
- **En este proyecto** — cómo y por qué se aplica aquí, qué pasaría si se hiciera distinto, cuándo dejaría de ser la opción correcta

## 4. Índice

`docs/estudio/INDEX.md` ordena las fichas existentes para releerlas de la base hacia lo particular, no por orden de creación. No anticipa temas: solo refleja lo que el humano pidió. Si no existe, créalo. Tres niveles:

1. **Fundamentos** — conceptos generales que no dependen del proyecto
2. **Herramientas y técnicas** — lo concreto que el proyecto usa
3. **El proyecto** — cómo se combinan las piezas anteriores aquí

Dentro de cada nivel, una ficha va después de las que lista en su sección "Antes de leer".

## 5. Entrega

Indica la ruta de la ficha, el orden de lectura sugerido y las preguntas. Ofrece revisar sus respuestas o su explicación con sus palabras contra las fuentes de la ficha, señalando qué falta o qué está impreciso.
