# Flujo de trabajo

- **Última actualización:** 2026-06-22

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
- Seguir convenciones definidas en `standards/convenciones.md`
- Seguir el adapter correspondiente si aplica (`adapters/`)
- Actualizar `board.json` a estado `en-progreso`

### 4. Validar
- Verificar criterios de aceptación definidos en el paso 1
- Revisar que no se rompan estándares existentes
- Ver `standards/calidad.md` para criterios mínimos

### 5. Registrar
- Actualizar `board.json` a estado `completada`
- Si se tomaron decisiones relevantes, confirmarlas en `decisions/`
- Si se descubrió algo que cambia `knowledge/`, proponer actualización al humano

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
