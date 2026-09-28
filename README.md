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

La rama `template` es la base limpia; `main` es donde se trabaja el framework en sí.

### 1. Llevar la base al proyecto
Copiar el contenido de la rama `template` (`CLAUDE.md`, `docs/`, `scripts/`, `.gitignore`, `.env.example`) a la raíz del proyecto, nuevo o existente. Si el proyecto ya tiene `.gitignore` o `README.md`, combinarlos en lugar de sobrescribirlos.

### 2. (Opcional) Traer la idea validada
Si la idea se discutió en otra app de IA, usar `docs/templates/prompt-inicializacion.md` al cierre de esa conversación y guardar el resumen resultante.

### 3. Abrir una sesión con el agente
El board de la base trae `meta.inicializado: false`, así que el agente arranca el flujo de inicialización (`docs/standards/inicializacion.md`) sin instrucciones adicionales:
> "Lee docs/CONSTITUTION.md primero."

El agente diagnostica el proyecto y, con tu aprobación en cada paso, adapta `knowledge/`, `standards/`, `adapters/`, `templates/` y los flujos de trabajo a lo que el proyecto necesita — sea de software o no.

### 4. Trabajar
Una vez inicializado, cada sesión sigue el protocolo normal de `docs/CONSTITUTION.md`.

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
