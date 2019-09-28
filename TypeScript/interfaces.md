# Interfaces

- Interfaces define the specifications for an entity.
  - Essentially declares what has to be done but doesn't really say _how_ to do it.
- An interface contains the name of all the properties along with their types.
  - It also includes the signature for functions along with the type of arguments and return type.
- A class or function can implement an interface to define the implementation of the properties defined in that interface.
- When utilizing optional parameters, use `?` afterwards.

```typescript
interface Person {
  name: string;
  age: number;
  // Optional param
  gender?: string;
  // Type function that returns a number
  numberOfPets: () => number;
}
```
