# Adapter: Jest (Testing)

- **Última actualización:** 2026-06-22

---

## Cuándo leer este archivo

Leer este adapter antes de cualquier tarea que involucre escribir, modificar o revisar tests en proyectos que usan Jest.
Si el proyecto tiene un framework específico (NestJS, React, etc.), leer también el adapter correspondiente para ver si hay configuración adicional.

---

## Tipos de test y su ubicación

| Tipo | Ubicación | Cuándo usarlo |
|---|---|---|
| Unit | Junto al archivo (`*.spec.ts`) | Lógica aislada de una función, clase o módulo |
| Integration | `test/` en raíz | Interacción entre múltiples módulos o capas |
| E2E | `test/` en raíz (`*.e2e-spec.ts`) | Flujo completo desde el punto de entrada del sistema |

---

## Nomenclatura

- Archivos unit: `nombre.spec.ts` junto a `nombre.ts`
- Archivos e2e: `nombre.e2e-spec.ts` dentro de `test/`
- `describe` principal: nombre de la unidad bajo test — `describe('UserService', ...)`
- `describe` anidado: el método o caso — `describe('findOne', ...)`
- `it`: comportamiento esperado en forma afirmativa — `it('returns null when user not found', ...)`

```typescript
describe('UserService', () => {
  describe('findOne', () => {
    it('returns the user when it exists', async () => { ... })
    it('returns null when user does not exist', async () => { ... })
    it('throws when id has invalid format', async () => { ... })
  })
})
```

---

## Setup estándar de un unit test

```typescript
describe('MiClase', () => {
  let instance: MiClase

  const mockDependencia = {
    metodo: jest.fn(),
  }

  beforeEach(() => {
    instance = new MiClase(mockDependencia as any)
  })

  afterEach(() => {
    jest.clearAllMocks()
  })

  it('hace lo esperado', () => {
    mockDependencia.metodo.mockReturnValue('resultado')
    expect(instance.ejecutar()).toBe('resultado')
  })
})
```

---

## Reglas de mocking

- Mockear dependencias externas (base de datos, APIs, servicios externos), no la unidad que se testea
- Definir mocks fuera del `it`, configurar su retorno dentro de cada `it`
- Usar `jest.clearAllMocks()` en `afterEach` para evitar contaminación entre tests
- Preferir `mockResolvedValue` / `mockReturnValue` sobre implementaciones complejas
- No mockear módulos built-in de Node.js salvo casos excepcionales — si necesitas hacerlo, revisar el diseño

```typescript
it('devuelve null cuando no existe', async () => {
  mockRepo.findOne.mockResolvedValue(null)
  const result = await service.findOne('id-inexistente')
  expect(result).toBeNull()
})
```

---

## Cobertura

No hay porcentaje obligatorio. Se espera cobertura de:
- Toda la lógica de negocio y sus casos límite
- Errores y excepciones conocidos (not found, validación fallida, conflicto)
- Código condicional (`if`, `switch`, guards)

No es necesario testear:
- Código que solo delega sin lógica propia (lo cubren los tests de integración o e2e)
- Configuración y bootstrapping del framework

---

## Configuración base de Jest

```javascript
// jest.config.js
module.exports = {
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: 'src',
  testRegex: '.*\\.spec\\.ts$',
  transform: { '^.+\\.(t|j)s$': 'ts-jest' },
  collectCoverageFrom: ['**/*.(t|j)s'],
  coverageDirectory: '../coverage',
  testEnvironment: 'node',
}
```

Para e2e, configuración separada en `test/jest-e2e.json`.

---

## Lo que este adapter no cubre

- Setup de base de datos en tests → definir en el adapter del ORM o base de datos correspondiente
- Testing de componentes UI → definir en el adapter del framework frontend correspondiente
- Configuración de CI → documentar en adapter de infraestructura si existe
