# Extending Types

- In Ruby and Js, think of inheriting from a class
- Types can be extended using `extends` keyword

```typescript
class ChildClass extends ParentClass {
  constructor() {
    super();
  }
}
```

The child class must call base class `super()` constructor, for example:

```typescript
class Vehicle {
  engine: Engine;
  constructor(engine: Engine) {
    this.engine = engine;
  }
}

// Truck derives from class Vehicle
class Truck extends Vehicle {
  v8: boolean;
  constructor(engine: Engine, v8: boolean) {
    // Call base class constructor
    super();
    this.v8 = v8;
  }
}
```
