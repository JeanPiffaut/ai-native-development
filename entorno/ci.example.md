# CI/CD

Última revisión: 2000-01-01

- **Plataforma:** GitLab (instancia corporativa), plantilla de pipeline incluida desde `grupo/plantillas`.
- **Runners:** `runner-ejemplo` (Terraform), `buildkit-ejemplo` (imágenes arm64).
- **Credenciales del CI:** rol de Terraform por proyecto (vault_role NNNN).

## Fallas conocidas y qué hacer

| Síntoma | Causa | Qué hacer |
|---|---|---|
| `connection refused` a buildkit | runner caído | reintentar el job; revisar que el deploy corra después de un build exitoso |
