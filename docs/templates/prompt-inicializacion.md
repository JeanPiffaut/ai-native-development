# Prompt de extracción de idea (para usar en apps externas)

- **Última actualización:** 2026-07-29

---

## Cuándo usarlo

Usalo al final de una conversación de ideación en una app completamente
aparte de este framework (ChatGPT, Gemini, Claude.ai u otra), donde validaste
una idea de proyecto nuevo. Esa app no tiene ninguna noción de cómo trabajamos
acá — ni falta que le hace. Este prompt solo le pide que ordene lo discutido
en un resumen completo y autocontenido, para que vos lo traigas después a
este framework.

---

## Instrucciones (pegar tal cual en la app externa, al cierre de la conversación)

```
Basándote en toda esta conversación, armá un resumen ordenado y completo de
la idea de proyecto que discutimos, pensado para que yo se lo entregue a otra
herramienta de desarrollo que no vio nada de este chat. No asumas que quien
lo lea tiene contexto previo.

Estructuralo así:

1. Qué es el proyecto — en 2-3 frases, qué construye y para quién
2. Problema que resuelve — qué dolor o necesidad concreta atiende
3. Usuario/s principal/es — quién lo usa y qué espera de él
4. Alcance — qué incluye la primera versión y qué queda explícitamente afuera
5. Conceptos clave y glosario — términos específicos del dominio que
   aparecieron, con su definición en una línea cada uno
6. Decisiones ya tomadas — cualquier elección de tecnología, arquitectura,
   estructura de datos o enfoque que hayamos acordado, indicando: qué se
   eligió, qué alternativas se consideraron y por qué se descartaron
7. Preguntas abiertas o incógnitas — todo lo que quedó sin resolver o
   pendiente de definir
8. Próximos pasos — qué habría que hacer primero para arrancar

Sé concreto, evitá relleno y no repitas la conversación textualmente. Si en
algún punto no hay información suficiente en lo que hablamos, decilo
explícitamente en vez de inventar contenido.
```

---

## Qué hacer con el resultado

Guardá la respuesta tal cual te la den. Llevala a este framework, abrí una
sesión nueva acá y pegásela al agente pidiéndole que la use como base para
completar `docs/knowledge/` y, si corresponde, dejar decisiones borrador en
`docs/decisions/`. El agente de este repo ya sabe cómo hacerlo siguiendo
`docs/CONSTITUTION.md` — no hace falta ninguna instrucción especial adicional
más que "acá está la idea validada, arranquemos el proyecto".

## Por qué el prompt no menciona nada de este framework

La app externa no tiene acceso a `CONSTITUTION.md`, `knowledge/` ni
`decisions/`, y pedirle que actúe como si los conociera no tiene efecto real
— en el mejor caso los ignora, en el peor inventa una estructura que no es la
nuestra. Por eso el prompt es genérico: solo pide una síntesis ordenada de la
idea, en vocabulario común (problema, usuario, decisiones, próximos pasos),
sin ningún término propio de este repo. El mapeo a `knowledge/` y
`decisions/` ocurre después, ya en este framework.
