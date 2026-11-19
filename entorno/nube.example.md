# Cuentas de nube y restricciones de la organización

Última revisión: 2000-01-01 · Fuente: consola, decisión NNN del proyecto X

| Ambiente | Proveedor | Cuenta | Región | Cómo se entra (rol o perfil) |
|---|---|---|---|---|
| dev | AWS | 000000000000 | us-east-1 | rol-ejemplo-admin (SSO) |
| prod | AWS | 111111111111 | us-east-1 | rol-ejemplo-admin (SSO) |

## Restricciones conocidas (SCP u otras)

- `p-ejemplo`: niega `s3:PutBucketPolicy` al rol del CI. Salida usada: aplicar a mano con el rol admin y adoptar con `import`.

## Qué proyecto usa qué

| Recurso compartido | Proyectos | Nota |
|---|---|---|
| Cluster de base de datos de prod | proyecto-a, proyecto-b | Lo comparten desde 2000-01-01 |
