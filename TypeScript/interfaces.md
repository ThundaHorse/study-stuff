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

When having a class that implements an interface, we can use "stubs".

```typescript
interface IEngine {
  // Stubs
  start(callback: (startStatus: bool, engineType: string) => void): void;
  stop(callback: (stopStatus: bool, engineType: string) => void): void;
}

class Engine implements IEngine {
  constructor(public horsePower: number, public engineType: string) {}

  start(callback: (startStatus: bool, engineType: string) => void) {
    window.setTimeout(() => {
      callback(true, this.engineType);
    }, 1000);
  }
  stop(callback: (stopStatus: bool, engineType: string) => void) {
    window.setTimeout(() => {
      callback(true, this.engineType);
    }, 1000);
  }
}
```

- If there is a `private` field, need to use `get()` to get the private field, otherwise `public` will have access to it.
  - Can use `set()` to 'set' a private field.

By implementing an interface, have to guarantee that the class using has those stubs. Javascript itself doesn't support interfaces.
