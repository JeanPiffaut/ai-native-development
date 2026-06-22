# [015] Editar standards/ y adapters/ es válido para correcciones y evolución del mismo concepto

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** 003 (parcialmente — solo en la regla de edición de archivos existentes)
- **Superada por:** —

---

## Contexto

La decisión [003] estableció que `standards/` y `adapters/` son directorios aditivos: "agregar algo nuevo siempre es crear un archivo, nunca editar los existentes".

En la práctica, cuando una convención evoluciona o se corrige una imprecisión en un archivo existente, crear un archivo nuevo no tiene sentido: el concepto es el mismo, solo cambia su formulación. Crear un archivo nuevo para corregir una frase incorrecta fragmenta el conocimiento y obliga al agente a reconciliar dos versiones del mismo concepto.

Los archivos `knowledge/principios.md` y `knowledge/dominio.md` ya recogen esta distinción actualizada, pero sin ADR que la respalde ni que marque [003] como parcialmente superada — lo que genera una contradicción entre una decisión confirmada y los archivos de knowledge.

## Alternativas consideradas

### Opción A — Mantener la regla de [003] tal cual
Cualquier cambio a un archivo de `standards/` o `adapters/` debe ser un archivo nuevo.
- Pro: consistencia absoluta con la regla append-only.
- Contra: obliga a crear archivos nuevos para correcciones menores o evolución del mismo concepto. El directorio se fragmenta. Un agente leyendo dos versiones del mismo concepto necesita reconciliarlas.

### Opción B — Editar es válido para correcciones y evolución; crear archivo nuevo para conceptos nuevos (elegida)
Distinguir dos casos:
- Corrección o evolución del mismo concepto → editar el archivo existente, registrar en su `## Historial de cambios`
- Concepto distinto o adición nueva → crear archivo nuevo
- `decisions/` mantiene la regla absoluta: nunca editar, solo agregar nuevas que superan a las anteriores
- Pro: el directorio queda cohesionado. El agente lee un archivo por concepto. El historial de cambios dentro del archivo provee trazabilidad.
- Contra: requiere juicio para distinguir "mismo concepto evolucionado" de "concepto distinto". Ese juicio es el mismo que aplica en cualquier decisión de diseño.

## Decisión

Editar un archivo existente en `standards/` o `adapters/` es válido cuando el cambio es una corrección o evolución del mismo concepto documentado en ese archivo. No es válido para incorporar un concepto distinto — en ese caso, crear un archivo nuevo.

Todo cambio significativo a un archivo de `standards/` se registra al final del archivo bajo `## Historial de cambios`. Los adapters pueden modificarse libremente sin ese requisito formal (su `Última actualización` en el encabezado es suficiente).

La restricción absoluta de no editar se mantiene solo para `decisions/`.

## Consecuencias

- La regla "nunca editar los existentes" de [003] queda reemplazada por la distinción de esta decisión para `standards/` y `adapters/`
- `CONSTITUTION.md §7` ya refleja el comportamiento correcto ("crecen por acreción")
- `knowledge/principios.md` y `knowledge/dominio.md` quedan alineados con un ADR que los respalda
- El agente puede editar standards/ y adapters/ directamente sin crear archivos nuevos cuando sea corrección o evolución

## Referencias

- Supera a [003] en la regla de edición de archivos existentes en `standards/` y `adapters/`; el resto de [003] (distinción standards vs adapters) se mantiene sin cambios
- `knowledge/principios.md` y `knowledge/dominio.md` ya documentan esta distinción desde 2026-06-22
