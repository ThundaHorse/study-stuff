# Modules

- Modules help keep separation in code.
  - Some pros are that they can be maintainable, testable, reusable, and separated.

Ways to defined a module:

```typescript
module someModule {
  // code
}

// OR Implicit modules
// No module declaration, imports/exports
class TestClass implements Test {
  // Global namespace
  // code
}

var t = new TestClass();
```

Modules are flexible, can be extended globally or within/across files.

Separation of concerns is another concept that modules address. Each module has a specific role. You can also choose what you make 'open' or what to bring in from other modules.
