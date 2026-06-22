# Adapter: NestJS

- **Última actualización:** 2026-06-22
- **Stack:** NestJS + TypeScript

---

## Cuándo leer este archivo

Leer este adapter antes de cualquier tarea que involucre código dentro de `src/` en proyectos que usan NestJS.

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
