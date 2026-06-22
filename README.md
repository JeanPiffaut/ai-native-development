# AI-Native Development Framework

Framework de estructura base para proyectos que trabajan con agentes de IA.
Agnóstico al modelo de lenguaje y al orquestador.

---

## Para agentes: empieza aquí

Lee `docs/CONSTITUTION.md` antes de hacer cualquier otra cosa.

---

## ¿Qué es esto?

Una plantilla de proyecto diseñada para que cualquier agente de IA pueda:
- Entender el contexto del proyecto al inicio de cada sesión
- Saber cómo comportarse sin que el usuario lo repita cada vez
- Registrar decisiones de forma trazable y consistente
- Retomar trabajo entre sesiones sin perder continuidad

---

## Cómo usar esta plantilla

### 1. Clonar
```bash
git clone <este-repo> mi-proyecto
cd mi-proyecto
```

### 2. Completar el contexto
Editar los archivos en `docs/knowledge/` con la información real del proyecto:
- `negocio.md` — qué es, para quién, qué problema resuelve
- `dominio.md` — glosario y conceptos clave
- `stakeholders.md` — quiénes participan
- `principios.md` — valores y criterios de decisión

### 3. Agregar el proyecto
El código, contenido o entregables del proyecto viven en `src/`.

### 4. Agregar adapters si aplica
Si el proyecto usa herramientas o tecnologías específicas, crear el adapter correspondiente en `docs/adapters/` siguiendo los ejemplos existentes.

### 5. Instruir al agente
Al iniciar una sesión con cualquier agente:
> "Lee docs/CONSTITUTION.md primero y luego declara tu entendimiento del proyecto."

---

## Estructura

```
proyecto/
├── README.md             ← Este archivo
├── docs/                 ← Framework de documentación
│   ├── CONSTITUTION.md   ← Contrato operativo para agentes (leer primero)
│   ├── board.json        ← Estado vivo del trabajo
│   ├── knowledge/        ← Contexto del proyecto
│   ├── decisions/        ← Registro append-only de decisiones
│   ├── standards/        ← Cómo se trabaja
│   ├── adapters/         ← Convenciones por herramienta o tecnología
│   └── templates/        ← Plantillas reutilizables
│
└── src/                  ← El proyecto real
```

---

## Archivos clave

| Archivo | Propósito | Quién lo modifica |
|---|---|---|
| `docs/CONSTITUTION.md` | Reglas del agente | Solo humano |
| `docs/board.json` | Estado del trabajo | Agente + humano |
| `docs/decisions/` | Historial de decisiones | Agente propone, humano confirma |
| `docs/knowledge/` | Contexto del proyecto | Humano (agente propone) |
| `docs/standards/` | Cómo se trabaja | Humano (agente propone) |
| `docs/adapters/` | Convenciones específicas | Agente + humano |

---

## Compatibilidad

Este framework usa Markdown y JSON. No requiere herramientas específicas.
Coexiste con archivos de configuración de orquestadores (`.claude/`, `.cursor/`, etc.) sin modificar la estructura de `docs/`.
