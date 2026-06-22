# Adapter: Docker

- **Última actualización:** 2026-06-22
- **Frecuencia de cambio:** Media — cambia cuando se agrega un servicio o se ajusta la infraestructura local

---

## Cuándo leer este archivo

Leer este adapter antes de cualquier tarea que involucre levantar, modificar o depurar el entorno de desarrollo, o cuando se trabaje con puertos, redes o servicios externos.

---

## Estructura del entorno local

El entorno de desarrollo corre completamente en Docker para garantizar consistencia entre máquinas.
`docker-compose.yml` en la raíz del proyecto define todos los servicios.

```
proyecto/
├── docker-compose.yml        ← entorno de desarrollo local
├── docker-compose.prod.yml   ← overrides para producción (si aplica)
├── Dockerfile                ← imagen de la aplicación principal
└── .env.example              ← variables documentadas (nunca commitear .env con valores reales)
```

---

## Puertos

Esta es la fuente de verdad para los puertos del proyecto. El mapeo es `HOST:CONTENEDOR`.
El puerto del contenedor viene de `PORT` en `.env`. El puerto del host es fijo por servicio para evitar conflictos entre proyectos en la misma máquina.

| Servicio | Puerto host | Puerto contenedor | Variable |
|---|---|---|---|
| App principal | Por definir | `${PORT}` | `PORT` en `.env` |

*Agregar una fila por cada servicio que exponga un puerto.*

**Regla:** el puerto del host se define aquí y no cambia entre desarrolladores. Si hay conflicto con otro proyecto local, documentarlo en esta tabla y coordinarlo en equipo — no cambiarlo unilateralmente.

---

## Servicios del proyecto

*Completar cuando los servicios estén definidos.*

```yaml
# docker-compose.yml — estructura base
services:
  app:
    build: .
    ports:
      - "${APP_HOST_PORT}:${PORT}"
    env_file:
      - .env
    volumes:
      - ./src:/app/src        # hot reload en desarrollo
    depends_on:
      - db

  db:
    image: postgres:16-alpine
    ports:
      - "${DB_HOST_PORT}:5432"
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

---

## Dockerfile

Usar multi-stage build para mantener la imagen de producción liviana:

```dockerfile
# Verificar versión LTS activa en https://hub.docker.com/_/node antes de cambiar la imagen base
# Versión en uso: node:24-alpine (actualizada 2026-06-22)

# Stage 1: build
FROM node:24-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: producción
FROM node:24-alpine AS production
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY --from=builder /app/dist ./dist
USER node
EXPOSE ${PORT}
CMD ["node", "dist/main"]
```

Principios:
- Siempre `USER node` en producción — nunca correr como root
- `npm ci` en lugar de `npm install` — instalación determinista
- Las variables de entorno se inyectan en runtime, no en build time
- Al actualizar la versión de Node, actualizar ambos stages y registrar la fecha en el comentario

---

## Comandos de uso frecuente

```bash
# Levantar el entorno completo
docker compose up

# Levantar en background
docker compose up -d

# Ver logs de un servicio
docker compose logs -f app

# Reconstruir imagen después de cambios en Dockerfile o dependencias
docker compose up --build

# Detener y eliminar contenedores (preserva volúmenes)
docker compose down

# Detener y eliminar contenedores y volúmenes (reset completo)
docker compose down -v

# Ejecutar comando dentro del contenedor
docker compose exec app sh
```

---

## Cuándo reconstruir la imagen

Reconstruir con `--build` cuando:
- Se modificó el `Dockerfile`
- Se agregaron o eliminaron dependencias (`package.json`)

No es necesario reconstruir cuando:
- Se modificó código fuente (el volumen en desarrollo lo sincroniza)
- Se modificó `.env` (reiniciar el servicio es suficiente: `docker compose restart app`)

---

## Lo que este adapter no cubre

- Configuración de producción y deploy → documentar en adapter de infraestructura o CI/CD
- Variables de entorno disponibles → ver `adapters/env-config.md`
