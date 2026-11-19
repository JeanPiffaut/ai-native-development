# Permisos IAM: repo de permisos de la organización

Última revisión: 2000-01-01 · Fuente: repo de permisos, MR !NN

- **Repo:** `grupo/permisos/repo-ejemplo` (lo gestiona el equipo de seguridad). Ramas: `dev` → `master`.
- **Qué vive ahí:** roles y policies de cada proyecto, con prefijo `org-proyecto-`.
- **Validación:** Access Analyzer (`validate-policy`) en el pipeline; tiene que pasar sin hallazgos.

## Cómo pedir un permiso

1. Rama desde `dev`, policy con ARN exactos (sin comodines en ids) y condición por etiqueta donde se pueda.
2. MR a `dev` y luego `dev` → `master`; revisión del equipo de seguridad.
3. Después del deploy: revisar los jobs de despliegue de policies y roles, y verificar en IAM.

## Fallas conocidas

- Comodín en el id de un API de execute-api: Access Analyzer lo rechaza.
