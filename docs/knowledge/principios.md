# Principios

- **Última actualización:** YYYY-MM-DD

---

## Principios de diseño

*Los criterios que guían las decisiones cuando hay múltiples opciones válidas.*
*Ordenados por prioridad — ante conflicto entre principios, gana el primero.*

1. **Agnóstico al modelo y orquestador** — El framework no puede depender de una herramienta específica. Cualquier agente, con cualquier orquestador, debe poder leer los archivos y operar. Si una decisión de diseño ata el framework a una herramienta concreta, es una decisión incorrecta.

2. **Archivos sobre memoria** — Todo el contexto relevante vive en archivos, nunca solo en la memoria del modelo. Si algo es importante, está escrito. Si no está escrito, no existe para el agente.

3. **Aditivo, nunca destructivo** — La forma preferida de incorporar algo nuevo es siempre crear un archivo nuevo. Para `decisions/` esto es absoluto: nunca se editan, solo se agregan nuevas que superan a las anteriores. Para `standards/` y `adapters/`, editar un archivo existente es válido cuando el cambio es una corrección o evolución del mismo concepto — no para incorporar un concepto distinto; en ese caso, crear un archivo nuevo.

4. **Trazabilidad del por qué** — No basta con documentar qué se decidió — hay que documentar por qué y qué alternativas se descartaron. Una decisión sin contexto pierde su valor en semanas.

5. **Mínima fricción para el agente** — El protocolo de sesión debe ser ejecutable desde el primer mensaje sin instrucciones adicionales del usuario. El agente lee, declara y trabaja.

## Lo que nunca hacemos

*Antipatrones o decisiones explícitamente descartadas para este proyecto.*

- *No hacemos X porque Y*
- *No hacemos X porque Y*

## Criterios de calidad

*¿Cómo se ve "bien hecho" en este proyecto? ¿Qué estándares mínimos debe cumplir cualquier entrega?*

## Deuda aceptada

- **Gestión manual de mejoras** — cuando un proyecto descubre algo que debería estar en la base, el developer lo lleva manualmente al repo del framework. No hay mecanismo automático. Se acepta porque los proyectos son pocos y la frecuencia de cambio del framework base es baja.
- **Knowledge como punto de entrada humano** — los archivos en `knowledge/` no se llenan automáticamente al clonar. Requieren intervención humana. Se acepta porque el contexto de negocio no puede inferirse.

---

## Historial de cambios

- **2026-06-22** — Principio 3 ("Aditivo, nunca destructivo") aclarado: la restricción absoluta de no editar aplica solo a `decisions/`; para `standards/` y `adapters/` editar es válido cuando el cambio es corrección o evolución del mismo concepto.
