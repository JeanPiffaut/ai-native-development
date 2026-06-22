# Clean Code

- **Última actualización:** 2026-06-22

---

## Propósito

Este estándar define los principios de escritura de código que aplican a este proyecto independientemente del lenguaje o framework.
El objetivo es que el código sea legible, mantenible y predecible — para humanos y para agentes de IA.

---

## Nombres

Los nombres deben revelar intención. Un nombre que requiere un comentario para entenderse es un nombre que hay que cambiar.

- **Variables y funciones:** nombres que describen qué son o qué hacen, no cómo lo hacen
- **Booleanos:** prefijos `is`, `has`, `can`, `should` — `isActive`, `hasPermission`
- **Funciones:** verbos — `getUserById`, `calculateTotal`, `sendNotification`
- **Clases:** sustantivos — `UserRepository`, `OrderService`, `PaymentGateway`
- **Evitar:** abreviaciones, nombres genéricos (`data`, `info`, `temp`, `obj`), números en nombres

```typescript
// Mal
const d = new Date()
const u = getU(id)
function process(data) { ... }

// Bien
const createdAt = new Date()
const user = getUserById(id)
function processPayment(order: Order) { ... }
```

---

## Funciones

- Hacen una sola cosa
- Su nombre describe completamente lo que hacen — si necesitas leer el cuerpo para entender el nombre, hay que renombrar o dividir
- Sin efectos secundarios ocultos — si una función modifica estado externo además de retornar un valor, debe ser obvio en el nombre
- Máximo 3 parámetros; más de 3 → encapsular en un objeto
- Sin flags booleanos como parámetro — son señal de que la función hace dos cosas

```typescript
// Mal — flag booleano
function getUser(id: string, includeDeleted: boolean) { ... }

// Bien — dos funciones con intención clara
function getUser(id: string) { ... }
function getDeletedUser(id: string) { ... }
```

---

## Comentarios

El código bien escrito no necesita comentarios para explicar *qué* hace.
Los comentarios explican *por qué* — una restricción no obvia, una decisión contraintuitiva, un workaround.

```typescript
// Mal — explica qué (ya lo dice el código)
// Incrementa el contador
counter++

// Bien — explica por qué
// La API externa falla si se envían más de 100 ítems por lote
const BATCH_SIZE = 100
```

Nunca:
- Comentarios desactualizados que contradicen el código
- Código comentado — si no se usa, se elimina; para eso existe git
- TODO sin dueño ni fecha — va al `board.json`

---

## Tamaño y estructura

- **Funciones cortas:** preferir que quepan en pantalla sin scroll
- **Un nivel de abstracción por función:** no mezclar lógica de alto nivel (orquestar) con lógica de bajo nivel (manipular strings, hacer queries)
- **Sin anidamiento profundo:** máximo 2-3 niveles de `if/for` anidados; extraer a funciones si hay más
- **Early return:** reducir anidamiento retornando temprano en los casos límite

```typescript
// Mal — anidamiento profundo
function processOrder(order) {
  if (order) {
    if (order.items.length > 0) {
      if (order.isPaid) {
        // lógica principal
      }
    }
  }
}

// Bien — early return
function processOrder(order) {
  if (!order) return
  if (order.items.length === 0) return
  if (!order.isPaid) return
  // lógica principal
}
```

---

## Manejo de errores

- Los errores son parte del flujo, no casos excepcionales — manejarlos explícitamente
- No silenciar errores con `catch` vacíos
- No retornar `null` para indicar error — lanzar excepción o retornar un tipo explícito (`Result`, `Option`)
- Los mensajes de error deben ser accionables: decir qué pasó y, si es posible, qué hacer

---

## DRY con criterio

No repetir lógica, pero tampoco abstraer prematuramente.
La regla de tres: si algo se repite tres veces, abstraerlo. Si se repite dos veces, esperar.
Una abstracción incorrecta es más cara que duplicación.

---

## Lo que este estándar no reemplaza

- Las convenciones de nomenclatura de archivos están en `standards/convenciones.md`
- Los patrones de arquitectura están en `standards/clean-architecture.md`
- Las reglas específicas del lenguaje o framework están en su adapter correspondiente
