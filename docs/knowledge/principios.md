# Principios

- **Última actualización:** 2026-06-22

---

## Principios de diseño

Ordenados por prioridad — ante conflicto entre principios, gana el primero.

1. **Agnóstico al modelo y orquestador** — El framework no puede depender de una herramienta específica. Cualquier agente, con cualquier orquestador, debe poder leer los archivos y operar. Si una decisión de diseño ata el framework a una herramienta concreta, es una decisión incorrecta.

2. **Archivos sobre memoria** — Todo el contexto relevante vive en archivos, nunca solo en la memoria del modelo. Si algo es importante, está escrito. Si no está escrito, no existe para el agente.

3. **Aditivo, nunca destructivo** — La forma preferida de incorporar algo nuevo es siempre crear un archivo nuevo. Para `decisions/` esto es absoluto: nunca se editan, solo se agregan nuevas que superan a las anteriores. Para `standards/` y `adapters/`, editar un archivo existente es válido cuando el cambio es una corrección o evolución del mismo concepto — no para incorporar un concepto distinto; en ese caso, crear un archivo nuevo.

4. **Trazabilidad del por qué** — No basta con documentar qué se decidió — hay que documentar por qué y qué alternativas se descartaron. Una decisión sin contexto pierde su valor en semanas.

5. **Mínima fricción para el agente** — El protocolo de sesión debe ser ejecutable desde el primer mensaje sin instrucciones adicionales del usuario. El agente lee, declara y trabaja.

## Lo que nunca hacemos

- No editamos decisiones confirmadas — si cambia la decisión, se crea una nueva que la supera
- No ponemos lógica de negocio en CONSTITUTION.md — eso va en `knowledge/principios.md`
- No creamos dependencias de herramientas específicas en `standards/` — eso va en `adapters/`
- No asumimos versiones de herramientas desde el conocimiento de entrenamiento — siempre verificar en la web
- No resolvemos ambigüedades silenciosamente — preguntar antes de implementar

## Criterios de calidad del framework

Una mejora al framework es válida si:
- Un agente que no conoce el proyecto puede seguirla sin aclaraciones adicionales
- No rompe la compatibilidad con proyectos que ya usan el framework
- Mantiene la separación entre standards y adapters

## Deuda aceptada

- **Gestión manual de mejoras** — cuando un proyecto descubre algo que debería estar en la base, el developer lo lleva manualmente al repo del framework. No hay mecanismo automático. Se acepta porque los proyectos son pocos y la frecuencia de cambio del framework base es baja.
- **Knowledge como punto de entrada humano** — los archivos en `knowledge/` no se llenan automáticamente al clonar. Requieren intervención humana. Se acepta porque el contexto de negocio no puede inferirse.

---

## Historial de cambios

- **2026-06-22** — Principio 3 ("Aditivo, nunca destructivo") aclarado: la restricción absoluta de no editar aplica solo a `decisions/`; para `standards/` y `adapters/` editar es válido cuando el cambio es corrección o evolución del mismo concepto.
