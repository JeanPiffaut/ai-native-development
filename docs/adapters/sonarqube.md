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

## Cómo ejecutar el análisis localmente

*Completar cuando la configuración local esté disponible.*

```bash
# Ejemplo base — ajustar según la configuración del proyecto
npm run sonar
```

Variables de entorno requeridas para el análisis:
- Ver `adapters/env-config.md` para las variables `SONAR_*`

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
