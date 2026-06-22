# Adapter: NestJS

- **Última actualización:** 2026-06-22
- **Stack:** NestJS + TypeScript

---

## Cuándo leer este archivo

Leer este adapter antes de cualquier tarea que involucre código dentro de `src/` en proyectos que usan NestJS, o al inicializar un proyecto nuevo con este stack.

---

## Inicialización

> Verificar la versión actual del CLI antes de instalar: https://www.npmjs.com/package/@nestjs/cli

```bash
# Instalar CLI globalmente
npm install -g @nestjs/cli

# Crear proyecto nuevo — el CLI preguntará el package manager a usar
nest new src
```

La carpeta `src/` generada por NestJS convive con `docs/` en la raíz del repositorio.

El entorno de desarrollo corre a través de Docker — ver `adapters/docker.md`.

```bash
# Levantar el entorno completo
docker compose up
```

---

## Comandos útiles

```bash
# Generadores — solo para esqueletos individuales
nest g module nombre      # módulo
nest g service nombre     # servicio
nest g controller nombre  # controller

# Tests (correr dentro del contenedor o con nx run)
npm run test              # unit tests
npm run test:e2e          # end-to-end
npm run test:cov          # con cobertura

# Build
npm run build
```

---

## Estructura de carpetas en src/

```
src/
├── modules/          ← Un módulo por dominio de negocio
│   └── [modulo]/
│       ├── [modulo].module.ts
│       ├── [modulo].controller.ts
│       ├── [modulo].service.ts
│       ├── dto/
│       └── entities/
├── common/           ← Código compartido entre módulos
│   ├── decorators/
│   ├── guards/
│   ├── interceptors/
│   └── pipes/
├── config/           ← Configuración de la aplicación
└── main.ts
```

---

## Convenciones de código

### Nomenclatura
- Archivos: `kebab-case.ts` — ej: `user-profile.service.ts`
- Clases: `PascalCase` — ej: `UserProfileService`
- Variables y funciones: `camelCase`
- Constantes: `UPPER_SNAKE_CASE`
- Interfaces: prefix `I` + PascalCase — ej: `IUserProfile`
- DTOs: suffix `Dto` — ej: `CreateUserDto`
- Entities: sin suffix — ej: `User`

### Módulos
- Un módulo por entidad de dominio principal
- Los módulos no se importan circularmente; usar eventos si hay dependencias cruzadas
- Exportar solo lo que otros módulos necesitan

### Servicios
- Lógica de negocio vive en services, nunca en controllers
- Los controllers solo validan entrada y delegan al service
- Los services no acceden directamente a la base de datos; usar repositorios

### DTOs
- Usar `class-validator` para validación en todos los DTOs de entrada
- Separar DTOs de entrada (`CreateXDto`, `UpdateXDto`) de los de salida si difieren

### Manejo de errores
- Usar excepciones de NestJS (`NotFoundException`, `BadRequestException`, etc.)
- No capturar errores silenciosamente en services
- Los errores inesperados los maneja el filtro global de excepciones

---

## Qué generar y qué crear a mano

Usar los generadores del CLI solo para esqueletos simples — producen el archivo vacío con la estructura correcta:

```bash
nest g module nombre
nest g service nombre
nest g controller nombre
```

Crear a mano (los generadores producen código que choca con clean architecture):
- Entidades — van en `domain/` sin decoradores de ORM
- DTOs — van en `application/` o `infrastructure/` según corresponda
- Repositorios — la interfaz en `domain/`, la implementación en `infrastructure/`
- Cualquier cosa que el generador `nest g resource` produciría — ese comando mezcla capas

---

## Testing

- Unit tests: junto al archivo que testean (`*.spec.ts`)
- E2E tests: en carpeta `test/` en la raíz
- Mocks: usar los módulos de testing de NestJS (`Test.createTestingModule`)
- Cobertura mínima: services y guards críticos deben tener tests

---

## Variables de entorno

- Todas las variables de entorno se tipan y validan con `@nestjs/config` + Joi o Zod
- No acceder a `process.env` directamente fuera de `config/`
- El archivo `.env.example` documenta todas las variables requeridas

---

## Decisiones específicas de este stack

Ver `decisions/` para las decisiones que aplicaron al elegir este stack y su configuración.

---

## Lo que este adapter no cubre

- Decisiones de base de datos → ver adapter de base de datos correspondiente
- Autenticación → ver `decisions/` sobre la estrategia de auth elegida
- Deploy e infraestructura → documentar en adapter separado
