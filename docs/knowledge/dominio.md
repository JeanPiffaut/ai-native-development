# Dominio

- **Última actualización:** YYYY-MM-DD

---

## Glosario

*Lista de términos clave del proyecto con su definición precisa. Incluir sinónimos y términos a evitar.*

| Término | Definición | Sinónimos | Evitar usar |
|---------|-----------|-----------|-------------|
| *término* | *qué significa en este contexto específico* | | |

## Conceptos centrales

*Los 3-5 conceptos más importantes para entender cómo funciona este proyecto. Más detalle que el glosario.*

### Standards vs Adapters
Los standards definen *cómo trabajamos* independientemente del stack — aplican en cualquier proyecto. Los adapters definen *cómo usamos una herramienta específica* — solo aplican si el proyecto usa esa herramienta. Ambos crecen preferentemente por acreción: incorporar algo nuevo significa crear un archivo nuevo. Editar un archivo existente es válido cuando el cambio es una corrección o evolución del mismo concepto — nunca para incorporar un concepto distinto en el mismo archivo.

### [Concepto 2]
*Explicación. Cómo se relaciona con otros conceptos.*

## Relaciones entre conceptos

```
CONSTITUTION
    └── define cómo leer →  knowledge/ + decisions/ + standards/ + adapters/
                                                          ↑
board.json ←── estado vivo del trabajo                   │
    │                                                     │
    └── referencias →  decisions/ ────────────────────────┘
```

## Reglas del dominio

- Una decisión confirmada nunca se edita — solo se supera con una nueva
- Todo lo que esté en `standards/` debe aplicar sin importar el stack tecnológico
- Todo lo que esté en `adapters/` solo aplica si el proyecto usa esa herramienta
- El agente no puede confirmar una decisión sin aprobación humana
- `CONSTITUTION.md` tiene precedencia sobre cualquier otro archivo del proyecto

---

## Historial de cambios

- **2026-06-22** — Sección "Standards vs Adapters" aclarada: "crecen por acreción" en lugar de "nunca se editan", para alinear con el protocolo de historial de cambios de `standards/convenciones.md`.
