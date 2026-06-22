# [008] Carpeta .tmp/ para reportes efímeros de análisis

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al definir dónde guardar los reportes generados por herramientas de análisis (SonarQube), se necesitaba un lugar que fuera accesible durante la sesión de trabajo pero que no se versionara ni acumulara en el repositorio.

## Alternativas consideradas

### Opción A — Reportes en docs/reports/
- Pro: organizados junto a la documentación.
- Contra: se versiona y acumula. Los reportes son snapshots puntuales sin valor histórico en git.

### Opción B — Reportes en .tmp/ (elegida)
- Pro: ignorado por git. Fuerza que el developer revise y procese los reportes antes de actuar — si no los procesa, desaparecen. Señal clara de que el contenido es temporal.
- Contra: los reportes se pierden si no se procesan en la misma sesión.

## Decisión

Los reportes generados por herramientas de análisis se guardan en `.tmp/`, que está en `.gitignore`. El flujo intencionado es: generar → revisar → actuar → `.tmp/` queda vacío.

## Consecuencias

- `.tmp/` está en `.gitignore`
- Los reportes no se acumulan ni generan ruido en el historial de git
- El developer debe procesar los reportes en la misma sesión o volver a generarlos
- Cualquier herramienta que genere reportes temporales usa `.tmp/` por convención
