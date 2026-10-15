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

- `estudio/<concepto-en-kebab-case>.md` — una ficha por concepto (ej. `jwt.md`, `docker-volumes.md`, `muestreo-estratificado.md`)
- Se crean con `templates/estudio.md`
- Antes de crear una ficha, revisar si ya existe una que cubra el concepto; si existe, se amplía en lugar de duplicarla

---

## Fuera del contexto de trabajo

`estudio/` es material para el humano, no contexto para el agente. No es fuente de verdad y no orienta cómo se trabaja: para eso están `knowledge/`, `decisions/`, `standards/` y `adapters/`.

- No se lee en el protocolo de inicio de sesión ni durante la inicialización (`standards/inicializacion.md`)
- No se usa como contexto para tareas, propuestas ni decisiones, aunque una ficha trate el tema en cuestión
- El agente solo abre la ficha concreta que el humano pidió crear, ampliar o revisar
- Para saber si un concepto ya tiene ficha, basta con ver los nombres de archivo o `estudio/INDEX.md`, sin leer el contenido de las fichas

---

## Ruta de estudio

`estudio/INDEX.md` ordena las fichas que ya existen para que se puedan releer de la base hacia lo particular, no en el orden en que se crearon. No anticipa fichas ni temas pendientes: solo refleja lo que el humano ya pidió. Se agrupan en tres niveles:

1. **Fundamentos** — conceptos generales que no dependen del proyecto (ej. qué es un token de autenticación, qué es una muestra representativa)
2. **Herramientas y técnicas** — lo concreto que el proyecto usa (ej. JWT, Docker, una librería de análisis)
3. **El proyecto** — cómo se combinan las piezas anteriores en este proyecto en particular

Dentro de cada nivel, una ficha va después de las que aparecen en su sección "Antes de leer". El agente actualiza el índice cada vez que crea una ficha o cambia sus prerequisitos.

---

## Qué es y qué no es una ficha

| Una ficha es | Una ficha no es |
|---|---|
| Explicación breve del concepto, con palabras propias | Una copia o resumen largo de la documentación |
| Una guía de qué leer, dónde y en qué orden | Un tutorial paso a paso |
| Un puente entre el concepto y su uso en este proyecto | Una bitácora de tareas |
| Un documento vivo que se amplía | Un registro de por qué se decidió algo — eso vive en `decisions/` |

Si el concepto está ligado a una decisión, la ficha enlaza a la decisión y no repite su razonamiento.

---

## Reglas sobre las fuentes

- **Solo fuentes consultadas de verdad.** El agente incluye únicamente las referencias que leyó para trabajar o para armar la ficha. Nunca ligas inventadas ni reconstruidas de memoria
- **Primarias primero.** Documentación oficial, especificaciones, RFC, papers o el código fuente antes que blogs o tutoriales de terceros
- **Cada fuente dice qué leer.** Una línea con la sección concreta y por qué sirve; una liga sin indicación no sirve como guía
- **Fecha de consulta.** Cada fuente registra cuándo se consultó, para detectar referencias que pudieron quedar obsoletas

---

## Preguntas de comprensión

Cada ficha cierra con preguntas para que el humano compruebe si entendió. Suben de nivel de exigencia — de recordar y entender hacia aplicar, analizar y evaluar (taxonomía de Bloom):

- **Sobre el concepto** — qué es, cómo funciona, qué problema resuelve
- **En este proyecto** — cómo y por qué se aplica aquí, qué pasaría si se hiciera distinto, cuándo dejaría de ser la opción correcta

Las preguntas no incluyen respuestas. Si el humano quiere, responde en la sesión o explica el concepto con sus palabras, y el agente lo revisa contra las fuentes de la ficha señalando qué falta o qué está impreciso.

---

## Lo que este estándar no hace

- No obliga a crear fichas en cada tarea
- No reemplaza el registro de decisiones ni el glosario de `knowledge/dominio.md` (términos del negocio, no de las herramientas)
- No decide qué debe estudiar el humano — solo responde a lo que pide

---

## Historial de cambios

- **2026-10-15** — Encabezado: agregado el campo `Lectura` (siempre).
