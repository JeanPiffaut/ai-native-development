# Adapter: Variables de entorno

- **Última actualización:** 2026-06-22
- **Frecuencia de cambio:** Alta — se actualiza cada vez que se agrega o modifica una variable

---

## Cuándo leer este archivo

Leer este adapter antes de cualquier tarea que agregue, modifique o consuma variables de entorno.

---

## Principios

- Ningún valor de configuración vive hardcodeado en el código — siempre a través de variables de entorno
- Toda variable nueva se documenta aquí en el mismo commit o sesión en que se agrega al código
- El archivo `.env.example` en la raíz del proyecto refleja exactamente las variables de esta tabla — son la misma fuente de verdad
- Nunca commitear `.env` con valores reales — solo `.env.example` con valores de ejemplo o vacíos

---

## Variables del proyecto

| Variable | Descripción | Ejemplo | Requerida | Entornos |
|---|---|---|---|---|
| `ENVIRONMENT` | Entorno de ejecución del proyecto | `development` | Sí | todos |
| `PORT` | Puerto interno del contenedor o proceso | `3000` | Sí | todos |
| `SONAR_HOST_URL` | URL del servidor SonarQube | `https://sonar.miempresa.com` | Solo para análisis | local / CI |
| `SONAR_TOKEN` | Token de autenticación de SonarQube | — | Solo para análisis | local / CI |
| `SONAR_PROJECT_KEY` | Clave del proyecto en SonarQube | `mi-proyecto` | Solo para análisis | local / CI |

*Esta tabla crece con el proyecto. Agregar una fila por cada variable nueva.*

---

## Categorías de variables

A medida que el proyecto crezca, organizar las variables por categoría en la tabla:

- **App** — configuración general (`ENVIRONMENT`, `PORT`, `APP_URL`)
- **Base de datos** — conexión y pool (`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`)
- **Auth** — claves y tokens (`JWT_SECRET`, `JWT_EXPIRES_IN`)
- **Servicios externos** — APIs de terceros (`STRIPE_SECRET_KEY`, `SENDGRID_API_KEY`)
- **Observabilidad** — logging y monitoreo (`LOG_LEVEL`, `SENTRY_DSN`)

---

## Validación al arranque

Las variables de entorno deben validarse al iniciar la aplicación, no cuando se consumen.
Si falta una variable requerida, la aplicación debe fallar con un mensaje claro antes de estar disponible.

```typescript
// Ejemplo con Zod
const envSchema = z.object({
  ENVIRONMENT: z.enum(['development', 'test', 'production']),
  PORT: z.coerce.number(),
  DB_HOST: z.string().min(1),
})

export const env = envSchema.parse(process.env)
```

---

## Acceso en el código

- No acceder a `process.env` directamente fuera del módulo de configuración
- Importar siempre desde el módulo de config centralizado
- `PORT` siempre debe estar definido en `.env` — no asumir un valor por defecto en el código
- Ver `adapters/docker.md` para entender la diferencia entre puerto interno y puerto del host
- Ver el adapter del framework correspondiente para la integración específica (ej. `@nestjs/config`)

---

## Secretos y valores sensibles

- Contraseñas, API keys y tokens son secretos — nunca en el repositorio, ni en `.env.example`
- En `.env.example`, los secretos se documentan con el nombre de la variable y una descripción, valor vacío
- En producción, los secretos se inyectan desde un gestor (AWS Secrets Manager, Vault, variables del CI, etc.)
- Documentar aquí qué gestor se usa cuando esté definido
