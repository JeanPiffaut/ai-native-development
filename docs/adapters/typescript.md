# Adapter: TypeScript

- **Última actualización:** 2026-06-22

---

## Cuándo leer este archivo

Leer este adapter en cualquier tarea que involucre código TypeScript, independientemente del framework.

---

## Configuración base (tsconfig)

El proyecto debe correr en modo estricto. Configuración mínima recomendada:

```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitReturns": true,
    "esModuleInterop": true,
    "skipLibCheck": true
  }
}
```

`strict: true` activa la mayoría de las flags de seguridad. Las adicionales (`noUncheckedIndexedAccess`, `noImplicitReturns`) previenen errores comunes en tiempo de ejecución.

---

## Tipos

### Interface vs Type alias

- `interface` para definir la forma de objetos y contratos — especialmente cuando otros pueden extenderlos
- `type` para uniones, intersecciones, tipos derivados y aliases de tipos primitivos

```typescript
// Interface: forma de un objeto / contrato
interface User {
  id: string
  email: string
}

// Type: unión o tipo derivado
type UserId = string
type UserOrNull = User | null
type PartialUser = Partial<User>
```

### Nunca usar `any`

`any` desactiva el type checker. Alternativas según el caso:

- Tipo desconocido en tiempo de ejecución → `unknown` (requiere narrowing antes de usar)
- Tipo genérico → `<T>`
- Objeto con claves dinámicas → `Record<string, unknown>`
- Respuesta de API externa → definir tipo explícito o usar `unknown` y validar

### Nullabilidad

Con `strictNullChecks` activo, `null` y `undefined` son tipos distintos.

```typescript
// Mal — puede fallar en runtime
function getUser(id: string): User {
  return users.find(u => u.id === id) // retorna User | undefined
}

// Bien — honesto sobre la posibilidad de no encontrarlo
function getUser(id: string): User | null {
  return users.find(u => u.id === id) ?? null
}
```

Preferir `?? null` sobre `|| null` para no colapsar valores falsy legítimos (0, '', false).

### Enums

Evitar `enum` numérico — los valores no son autodocumentados y pueden producir comportamientos inesperados.
Preferir union types de strings o `const` objects:

```typescript
// Evitar
enum Status { Active, Inactive }

// Preferir — union type
type Status = 'active' | 'inactive'

// Preferir — const object cuando se necesitan iterar los valores
const STATUS = { Active: 'active', Inactive: 'inactive' } as const
type Status = typeof STATUS[keyof typeof STATUS]
```

---

## Generics

Usar generics cuando la lógica aplica a múltiples tipos sin perder información de tipo.
Nombrar con una letra mayúscula descriptiva: `T` para tipo genérico, `K` para key, `V` para value, `E` para error.

```typescript
// Resultado que puede ser éxito o error — sin perder el tipo
type Result<T, E = Error> = { ok: true; value: T } | { ok: false; error: E }

function divide(a: number, b: number): Result<number, string> {
  if (b === 0) return { ok: false, error: 'Division by zero' }
  return { ok: true, value: a / b }
}
```

---

## Imports

- Usar imports de tipo cuando solo se necesita el tipo en tiempo de compilación: `import type { User } from './user'`
- Agrupar imports: externos → internos → tipos
- Sin barrel exports (`index.ts`) salvo que el módulo sea una librería pública — dificultan el tree-shaking y el análisis estático

---

## Patrones a evitar

- `as` (type assertion) para silenciar errores — arreglar el tipo en su origen
- `!` (non-null assertion) salvo cuando el contexto garantiza que no es null y no hay otra forma
- `Object.keys()` sin tipar el resultado — usar `(Object.keys(obj) as (keyof typeof obj)[])`
- Tipos demasiado amplios (`object`, `{}`) — ser específico

---

## Lo que este adapter no cubre

- Configuración específica del bundler (Webpack, esbuild, Vite) → adapter correspondiente
- Convenciones de testing con TS → ver `adapters/jest.md`
- Decoradores y metadata (usados por NestJS, TypeORM) → ver `adapters/nestjs.md`
