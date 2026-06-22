# [009] La creación de tareas desde reportes de SonarQube es manual

- **Estado:** CONFIRMADA
- **Fecha:** 2026-06-22
- **Supera a:** —
- **Superada por:** —

---

## Contexto

Al diseñar el flujo de SonarQube, surgió la opción de automatizar la creación de tareas en `board.json` a partir de los issues detectados. Se desarrolló un script (`sonar-to-board.js`) y luego se descartó.

## Alternativas consideradas

### Opción A — Script automático sonar-to-board.js
Parsea el reporte y agrega tareas al board automáticamente.
- Pro: menos fricción, nada se pierde.
- Contra: SonarQube genera muchos issues — bugs menores, code smells de baja prioridad, falsos positivos. Un script que vuelca todo al board crea ruido que degrada la utilidad del board. Además viola el principio de que las tareas deben ser autoconclusivas y estar bien definidas.

### Opción B — Creación manual (elegida)
El developer revisa `.tmp/sonar-issues.json` y decide qué merece ser una tarea.
- Pro: el board refleja trabajo real y priorizado. Fuerza criterio sobre qué es accionable. Cada tarea que entra tiene un dueño consciente.
- Contra: requiere un paso manual. Aceptable porque el tiempo de revisión es parte del valor del análisis.

## Decisión

La creación de tareas a partir de reportes de SonarQube es siempre manual. El script `sonar-report.sh` provee información; el humano decide qué entra al board.

## Consecuencias

- `sonar-to-board.js` no existe en este proyecto
- El criterio para agregar una tarea desde SonarQube está documentado en `adapters/sonarqube.md`: ¿bloquea el quality gate o introduce riesgo real?
- Code smells menores, falsos positivos y deuda de baja prioridad no entran automáticamente al board
