# [001] Adopción del framework AI-native como estructura base de proyectos

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Se busca una forma estructurada de trabajar con agentes de IA en proyectos de cualquier tipo (técnicos y no técnicos) que permita:
- Que cualquier agente pueda retomar el trabajo sin necesidad de re-explicar el contexto
- Que las decisiones queden documentadas con su razonamiento
- Que los estándares de trabajo se mantengan consistentes entre sesiones y entre distintos modelos de IA
- Que el framework sea agnóstico al orquestador y al modelo de lenguaje utilizado

El problema principal que se resuelve es la pérdida de contexto entre sesiones y la falta de trazabilidad en las decisiones tomadas con ayuda de IA.

## Alternativas consideradas

### Opción A — Documentación ad-hoc
Crear documentación cuando sea necesario, sin estructura predefinida.
- Pro: Flexibilidad total, cero fricción inicial.
- Contra: Cada sesión parte de cero. Los agentes no saben qué leer ni cómo comportarse. La documentación se vuelve inconsistente.

### Opción B — Wiki o Notion
Usar una herramienta de documentación externa (Notion, Confluence, etc.).
- Pro: Interface amigable, fácil de mantener para humanos.
- Contra: No vive junto al código. Los agentes necesitan acceso especial. No hay convención sobre qué documentar.

### Opción C — Framework AI-native (elegida)
Estructura de carpetas y archivos en el mismo repositorio, con convenciones claras sobre qué documenta cada archivo y cómo se comportan los agentes.
- Pro: Vive junto al código. Cualquier agente puede leerlo sin herramientas especiales. Agnóstico al modelo y orquestador.
- Contra: Requiere disciplina para mantener actualizado. Fricción inicial de setup.

## Decisión

Se adopta el framework AI-native como estructura base para todos los proyectos. El framework incluye:
- `CONSTITUTION.md` como contrato operativo para agentes
- `knowledge/` para contexto estable del negocio o proyecto
- `decisions/` como registro append-only de decisiones
- `standards/` para convenciones de trabajo
- `adapters/` para especificidades por tecnología
- `board.json` como estado vivo del trabajo
- `templates/` centralizando los moldes reutilizables

## Consecuencias

- Todo proyecto nuevo parte clonando este repositorio como base
- El `src/` del proyecto real convive con la documentación en el mismo repositorio
- Los agentes leen `CONSTITUTION.md` al inicio de cada sesión sin excepción
- Las decisiones nunca se editan, solo se agregan nuevas que superseden las anteriores
- Se acepta el trade-off de mantener documentación actualizada a cambio de continuidad entre sesiones

## Referencias

- Conversación de diseño inicial del framework: 2026-06-22
