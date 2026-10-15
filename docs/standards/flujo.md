# Flujo de trabajo

- **Última actualización:** 2026-10-15
- **Lectura:** siempre

---

## Ciclo estándar de una tarea

```
1. Definir  →  2. Especificar  →  3. Implementar  →  4. Validar  →  5. Registrar
```

### 1. Definir
- La tarea existe en `board.json` con estado `pendiente`
- Si no existe, crearla antes de empezar
- Clarificar alcance y criterios de aceptación antes de escribir código o contenido

### 2. Especificar
- Para tareas complejas: describir el enfoque antes de implementar
- El agente propone, el humano aprueba
- Si hay decisiones de diseño involucradas, crear borrador en `decisions/`

### 3. Implementar

**Rama de la tarea** — antes de tocar cualquier archivo, la tarea se trabaja en su propia rama `<tipo>/<id>-<slug-en-kebab-case>`, creada desde `main` actualizado y solo con las operaciones permitidas en `standards/agentes.md` ("Sobre git"). Si hay cambios sin commitear o algo falla, el agente se detiene y avisa. Los pasos están en la skill `tarea`.

- Seguir convenciones definidas en `standards/convenciones.md`
- Seguir el adapter correspondiente si aplica (`adapters/`)
- Actualizar `board.json` a estado `haciendo`

### 4. Validar
- Verificar criterios de aceptación definidos en el paso 1
- Revisar que no se rompan estándares existentes
- Ver `standards/calidad.md` para criterios mínimos

### 5. Registrar
- Completar la tarea en `board.json` con la skill `board`, en la rama de la tarea
- Si se tomaron decisiones relevantes, confirmarlas con la skill `decision`
- Si se descubrió algo que cambia `knowledge/`, proponer actualización al humano
- Dejar la rama lista para el humano: indicar qué commitear y con qué mensaje. Commit, push y merge a `main` son humanos

---

## Flujo de una sesión de trabajo

```
Inicio de sesión
    ↓
Leer contexto (según CONSTITUTION.md §1)
    ↓
Declarar entendimiento y tarea a abordar
    ↓
Trabajar (ciclo estándar de tarea)
    ↓
Cierre de sesión (según CONSTITUTION.md §6)
```

---

## Manejo de bloqueos

Si durante la implementación surge un bloqueo:
1. Describir el bloqueo al usuario con claridad
2. Proponer al menos una alternativa si existe
3. No avanzar en dirección incierta sin confirmación
4. Agregar el bloqueo al board si requiere resolución fuera de la sesión

---

## Descubrimiento de deuda o problemas colaterales

Si durante el trabajo se detecta un problema no relacionado con la tarea actual:
1. Agregarlo a `board.json` con tipo `deuda` o `bug`
2. Continuar con la tarea original
3. Mencionarlo al usuario al final de la sesión

No interrumpir el flujo de trabajo para resolver problemas colaterales salvo que sean bloqueantes.

---

## Historial de cambios

- **2026-06-22** — Corregidos estados del board en pasos 3 y 5: `en-progreso` → `haciendo`; `estado completada` → eliminar tarea del JSON. Alineado con el schema definido en `standards/agentes.md`.
- **2026-06-22** — Paso 5 "Registrar": agregado el paso condicional de registrar en `meta.historial` antes de eliminar la tarea, alineado con [014].
- **2026-09-28** — Paso 3 "Implementar": agregado bloque "Rama de la tarea" (una tarea = una rama `<tipo>/<id>-<slug>` desde `main` actualizado). Paso 5: la rama queda lista para commit y merge humano. Según [017].
- **2026-09-28** — Paso 3: la referencia a [017] se reemplaza por `standards/agentes.md` ("Sobre git"), para que la regla sea autocontenida en proyectos derivados de `template`.
- **2026-10-15** — Encabezado: agregado el campo `Lectura` (siempre).
- **2026-10-15** — Paso 3: los pasos de git para crear la rama pasan a la skill `tarea`; queda la regla. Paso 5: completar la tarea y confirmar decisiones remiten a las skills `board` y `decision`.
