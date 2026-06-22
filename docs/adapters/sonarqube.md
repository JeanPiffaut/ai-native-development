# Adapter: SonarQube

- **Última actualización:** 2026-06-22
- **Frecuencia de cambio:** Baja — cambia cuando se ajustan umbrales o reglas del quality gate

---

## Cuándo leer este archivo

Leer este adapter antes de cualquier tarea que involucre análisis de calidad de código, configuración de SonarQube o interpretación de reportes.

---

## Propósito en este proyecto

SonarQube es la herramienta de análisis estático que verifica de forma continua:
- Cobertura de tests
- Bugs y vulnerabilidades detectables estáticamente
- Code smells y deuda técnica
- Duplicación de código

El análisis se ejecuta como parte del pipeline de CI. Una tarea no se considera completada si el quality gate de SonarQube falla.

---

## Quality Gate — umbrales activos

*Completar cuando SonarQube esté configurado en el proyecto.*

| Métrica | Umbral mínimo | Estado |
|---|---|---|
| Cobertura de nuevas líneas | Por definir | Pendiente |
| Bugs nuevos | 0 | Pendiente |
| Vulnerabilidades nuevas | 0 | Pendiente |
| Security Hotspots revisados | 100% | Pendiente |
| Duplicación de código nuevo | Por definir | Pendiente |

---

## Cómo obtener un reporte

```bash
bash scripts/sonar-report.sh
```

Genera seis archivos en `.tmp/` (ignorado por git):

| Archivo | Contenido |
|---|---|
| `sonar-quality-gate.json` | Estado del quality gate (PASS/FAIL) |
| `sonar-issues.json` | Bugs y vulnerabilidades CRITICAL/MAJOR activos |
| `sonar-hotspots.json` | Security hotspots pendientes de revisión |
| `sonar-code-smells.json` | Code smells CRITICAL/MAJOR |
| `sonar-new-code.json` | Todos los issues introducidos desde el último análisis |
| `sonar-metrics.json` | Cobertura, duplicación, LOC y contadores generales |

El script imprime un resumen en consola al terminar.

Variables de entorno requeridas (en `.env`):

| Variable | Descripción |
|---|---|
| `SONAR_HOST_URL` | URL del servidor SonarQube o SonarCloud |
| `SONAR_TOKEN` | Token de autenticación |
| `SONAR_PROJECT_KEY` | Clave del proyecto en SonarQube |

## Del reporte al board

La creación de tareas desde el reporte es una decisión humana — no automática. SonarQube genera muchos issues; no todos merecen ser una tarea. El flujo es:

1. Correr `sonar-report.sh` → revisar `.tmp/`
2. Filtrar qué issues son accionables ahora
3. Agregar manualmente las tareas relevantes a `board.json`
4. Vaciar `.tmp/` una vez procesado

El criterio para agregar una tarea: ¿bloquea el quality gate o introduce riesgo real? Si es un code smell menor, puede quedar como deuda aceptada o ignorarse.

---

## Archivo de configuración

El archivo `sonar-project.properties` en la raíz del proyecto define las fuentes, exclusiones y parámetros del análisis.

Exclusiones estándar a considerar:
```properties
sonar.exclusions=**/node_modules/**,**/dist/**,**/*.spec.ts,**/migrations/**
sonar.coverage.exclusions=**/main.ts,**/*.module.ts,**/migrations/**
```

---

## Cómo interpretar un reporte

- **Bugs** — errores detectables estáticamente; corregir antes de cerrar la tarea
- **Vulnerabilities** — problemas de seguridad; corregir antes de merging a main
- **Security Hotspots** — código sensible que requiere revisión manual; revisar y marcar como revisado o corregir
- **Code Smells** — deuda técnica; agregar al `board.json` si no es trivial, no bloquea el quality gate por defecto
- **Coverage** — si baja del umbral, agregar tests antes de merging

---

## Cuándo suprimir una regla

Suprimir una regla de SonarQube es una decisión que requiere:
1. Entender por qué la regla existe
2. Documentar explícitamente por qué no aplica en ese caso específico
3. Usar la anotación de supresión más específica posible (línea, no archivo completo)

Si la supresión aplica a un patrón recurrente del proyecto, registrar la decisión en `decisions/`.

---

## Lo que este adapter no cubre

- Configuración del servidor SonarQube o SonarCloud → documentar en el adapter de infraestructura
- Integración con el pipeline de CI → documentar en el adapter de CI/CD cuando exista
