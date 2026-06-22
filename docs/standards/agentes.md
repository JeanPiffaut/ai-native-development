# Agentes

- **Última actualización:** 2026-06-22

---

## Principios de comportamiento

Los agentes que trabajen en este proyecto deben operar bajo estos principios:

1. **Contexto antes de acción** — Leer antes de hacer. Nunca asumir el estado del proyecto.
2. **Transparencia sobre suposiciones** — Si algo no está documentado, declararlo como suposición y pedir confirmación.
3. **Alcance mínimo** — Hacer exactamente lo pedido. No refactorizar ni ampliar scope sin aprobación.
4. **Registro de decisiones** — Toda decisión relevante debe quedar documentada, no solo implementada.
5. **Preguntar es preferible a suponer** — Una pregunta concreta cuesta menos que deshacer trabajo mal dirigido.

---

## Protocolo de inicio (resumen ejecutivo)

El protocolo completo está en `CONSTITUTION.md §1`. Resumen:

```
1. Leer CONSTITUTION.md
2. Leer knowledge/ (negocio, dominio, principios)
3. Leer board.json
4. Leer últimas 3 decisiones en decisions/
5. Leer adapter relevante si aplica
6. Declarar: qué leí, estado del proyecto, tarea a abordar
```

---

## Cómo proponer una decisión

```
1. Detectar que se va a tomar una decisión relevante
2. Crear borrador en decisions/ usando templates/decision.md
3. Nombrar: NNN-titulo-en-kebab-case.md (estado: BORRADOR)
4. Presentar al usuario con las alternativas evaluadas
5. Esperar confirmación antes de marcar como CONFIRMADA
6. Implementar según la decisión confirmada
```

---

## Cómo actualizar el board

Formato de cada tarea en `board.json`:

```json
{
  "id": "T-NNN",
  "titulo": "Descripción corta de la tarea",
  "tipo": "feature | bug | deuda | investigacion | proceso",
  "estado": "pendiente | en-progreso | bloqueada | completada",
  "prioridad": "alta | media | baja",
  "contexto": "Por qué existe esta tarea. Qué la originó.",
  "decision_relacionada": "NNN o null",
  "creada": "YYYY-MM-DD",
  "actualizada": "YYYY-MM-DD"
}
```

---

## Versiones y conocimiento externo

El conocimiento de entrenamiento de un modelo tiene fecha de corte y las versiones quedan obsoletas rápidamente.

**Regla:** ante cualquier tarea que requiera definir o usar una versión específica de una herramienta, runtime, librería o imagen base, el agente debe buscar en la web la versión estable o LTS actual antes de proponer o escribir código.

Esto aplica a:
- Imágenes base de Docker (`node:24-alpine`, `postgres:16`, etc.)
- Versiones de dependencias en `package.json`
- Versiones de herramientas de CI o infraestructura
- Cualquier versión que aparezca en archivos de configuración

No aplica cuando:
- La versión está explícitamente fijada en `adapters/` o en archivos del proyecto — usar esa versión sin cambiarla
- El usuario indica la versión a usar — seguir su instrucción

---

## Límites del agente

El agente no debe:
- Tomar decisiones de arquitectura sin registrarlas
- Modificar `CONSTITUTION.md` o decisiones confirmadas
- Asumir que algo "no importa" sin verificarlo en `knowledge/principios.md`
- Resolver ambigüedades silenciosamente cuando afectan el diseño
- Asumir versiones de herramientas sin verificar — ver sección anterior

---

## Compatibilidad con distintos modelos y orquestadores

Este framework es agnóstico. Los archivos son Markdown plano y JSON.
No hay dependencias de herramientas específicas.

Si el orquestador o modelo tiene convenciones propias (ej. archivos de configuración específicos como `.claude/`, `.cursor/`), pueden coexistir con este framework sin modificar su estructura.
