# Máquina local

Última revisión: 2000-01-01

- **Docker:** Colima; solo se monta `$HOME` (repos fuera de `$HOME` no se ven en los contenedores).
- **Credenciales AWS locales:** archivos `.env.<amb>-admin` por proyecto, renovados desde el portal SSO (duran horas).
- **Herramientas que no están en la máquina:** terraform, aws CLI (se usan vía Docker o venv de los scripts).
