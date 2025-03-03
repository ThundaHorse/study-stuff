# JavaScript Questions

## Explain `Scope` in JavaScript

- In JS, each function gets its own scope.
- Scope is basically collection of variables as well as the rules for how those variables are accessed by name
  - Only code in that function can access that function's scoped variables
- A variable has to be unique within the same scope
  - Scope can be nested inside another scope
  - If one scope is nested inside another, code inside the innermost scope can access variables from either scope

### Objects

- The `object` type refers to a compound value where you can set properties (aka named locations) that each holds their own values of any type

#### Callback functions

- `callback` functions are functions that are passed to another function as an argument and executed after some operation has been completed.