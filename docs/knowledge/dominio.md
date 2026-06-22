# Dominio

- **Última actualización:** 2026-06-22

---

## Glosario

| Término | Definición | Sinónimos | Evitar usar |
|---------|-----------|-----------|-------------|
| CONSTITUTION | Archivo que define el contrato operativo del agente: qué lee, qué puede modificar, cómo se comporta | — | "instrucciones", "prompt del sistema" |
| ADR | Architecture Decision Record — documento que registra una decisión con su contexto, alternativas y consecuencias | Decisión, registro de decisión | "notas", "comentarios" |
| Adapter | Archivo que documenta convenciones específicas de una herramienta o tecnología concreta | — | "plugin", "módulo" |
| Standard | Archivo que documenta un principio o metodología de trabajo que aplica independientemente de la tecnología | — | "regla", "norma" |
| Board | Archivo `board.json` que representa el estado vivo de las tareas del proyecto | Tablero, backlog | "to-do list" |
| Contexto de sesión | Conjunto de archivos que el agente lee al iniciar una sesión para entender el estado del proyecto | — | "memoria", "historial" |
| Append-only | Política de `decisions/` donde los documentos nunca se editan; los cambios generan un nuevo documento | — | "inmutable" (no es lo mismo) |

## Conceptos centrales

### CONSTITUTION como contrato
La CONSTITUTION no es un prompt ni un conjunto de sugerencias — es un contrato operativo. Define permisos, protocolos y jerarquía de verdad. El agente no puede ignorarla ni reinterpretarla. Solo puede ser modificada por el humano.

### Archivos como memoria persistente
El contexto del agente vive en archivos, no en la memoria del modelo. Esto significa que persiste entre sesiones, sobrevive cambios de modelo, es auditable y se acumula con el tiempo. La diferencia entre un agente con archivos y uno sin ellos es la diferencia entre alguien que toma notas y alguien que no.

### Standards vs Adapters
Los standards definen *cómo trabajamos* independientemente del stack — aplican en cualquier proyecto. Los adapters definen *cómo usamos una herramienta específica* — solo aplican si el proyecto usa esa herramienta. Ambos son aditivos: se agrega un archivo nuevo, nunca se editan los existentes para incorporar algo nuevo.

### Decisions como historial append-only
Las decisiones nunca se editan. Si una decisión cambia, se crea una nueva que la supera. Esto garantiza que el historial de *por qué* se tomó cada decisión sea siempre legible y nunca se pierda contexto.

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
