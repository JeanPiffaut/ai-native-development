# Clean Architecture

- **Última actualización:** 2026-06-22

---

## Propósito

Este estándar define cómo se organiza el código en capas y cómo fluyen las dependencias entre ellas.
El objetivo es que el núcleo del negocio no dependa de frameworks, bases de datos ni interfaces externas — solo de sí mismo.

---

## La regla fundamental

**Las dependencias apuntan hacia adentro. Las capas internas no conocen a las externas.**

```
Frameworks / Drivers       ← capa más externa
    ↓
Interface Adapters
    ↓
Use Cases
    ↓
Entities                   ← capa más interna
```

Una entidad no sabe que existe una base de datos.
Un caso de uso no sabe que existe un HTTP controller.
La base de datos no dicta la forma de los datos del negocio.

---

## Las capas

### Entities (Entidades)
- Las reglas de negocio más fundamentales del sistema
- Objetos que encapsulan los datos y las reglas que los gobiernan
- Sin dependencias externas — ni frameworks, ni librerías, ni base de datos
- Cambian solo cuando cambian las reglas del negocio, nunca por cambios técnicos

```typescript
// Entidad: solo lógica de negocio pura
class Order {
  private items: OrderItem[]

  addItem(item: OrderItem): void {
    if (this.isClosed()) throw new Error('Cannot add items to a closed order')
    this.items.push(item)
  }

  total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0)
  }
}
```

### Use Cases (Casos de uso)
- Orquestan el flujo de datos hacia y desde las entidades
- Contienen la lógica de aplicación (no de negocio)
- Conocen las entidades, pero no saben nada de frameworks ni de la UI
- Un caso de uso = una acción del sistema (`CreateOrder`, `CancelOrder`, `GetOrderById`)

```typescript
// Caso de uso: orquesta sin saber de HTTP ni base de datos
class CreateOrderUseCase {
  constructor(private orderRepository: IOrderRepository) {}

  async execute(input: CreateOrderInput): Promise<Order> {
    const order = new Order(input.customerId)
    input.items.forEach(item => order.addItem(item))
    return this.orderRepository.save(order)
  }
}
```

### Interface Adapters (Adaptadores de interfaz)
- Convierten datos entre el formato que necesitan los casos de uso y el formato externo (HTTP, base de datos, CLI)
- Controllers, Presenters, Gateways, Repositories (implementaciones)
- Conocen los casos de uso, pero los casos de uso no los conocen a ellos

```typescript
// Controller: adapta HTTP → caso de uso
class OrderController {
  constructor(private createOrder: CreateOrderUseCase) {}

  async create(req: Request, res: Response) {
    const order = await this.createOrder.execute(req.body)
    res.status(201).json(order)
  }
}

// Repository: adapta caso de uso → base de datos
class OrderRepository implements IOrderRepository {
  async save(order: Order): Promise<Order> {
    return this.db.orders.insert(order.toJSON())
  }
}
```

### Frameworks & Drivers
- La capa más externa: frameworks web, bases de datos, librerías de terceros
- Código de configuración, bootstrapping, wiring de dependencias
- Idealmente, lo menos posible vive aquí — esta capa solo conecta

---

## La interfaz como frontera

Las capas internas definen interfaces que las capas externas implementan.
El caso de uso no depende de `PostgresOrderRepository` — depende de `IOrderRepository`.
Esto permite cambiar PostgreSQL por MongoDB sin tocar un solo caso de uso.

```typescript
// Definida en la capa de casos de uso
interface IOrderRepository {
  save(order: Order): Promise<Order>
  findById(id: string): Promise<Order | null>
}

// Implementada en la capa de adaptadores
class PostgresOrderRepository implements IOrderRepository { ... }
class InMemoryOrderRepository implements IOrderRepository { ... } // para tests
```

---

## Señales de que se está violando la arquitectura

- Un caso de uso importa directamente un ORM, un cliente HTTP o un framework
- Una entidad tiene decoradores de base de datos (`@Column`, `@Entity` de TypeORM)
- Un controller contiene lógica de negocio
- Cambiar la base de datos requiere modificar casos de uso
- Los tests de casos de uso requieren levantar el framework o la base de datos

---

## Aplicación práctica

La estructura de carpetas en `src/` debe reflejar las capas, no los tipos de archivo.

```
src/
├── domain/           ← Entities + interfaces de repositorios
│   └── order/
│       ├── order.entity.ts
│       └── order.repository.interface.ts
│
├── application/      ← Use Cases
│   └── order/
│       └── create-order.use-case.ts
│
├── infrastructure/   ← Interface Adapters + Frameworks
│   ├── http/
│   │   └── order.controller.ts
│   └── persistence/
│       └── order.repository.ts
│
└── main.ts           ← Bootstrapping y wiring
```

---

## Lo que este estándar no reemplaza

- Los patrones de escritura de código están en `standards/clean-code.md`
- La estructura específica de carpetas según el framework está en su adapter correspondiente
- Si el proyecto adopta una variante (Hexagonal, DDD), documentar en una nueva decisión en `decisions/`
