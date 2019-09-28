# Object Types

- Objects can contain
  - properties
    - public/private
    - required/optional
  - call/construct/index signatures

Can define using object literals or explicitly.

```typescript
var square = {
  h: 10,
  w: 10
};

var rectangle: Object = {
  x: 10,
  y: 20
};
```

- Functions are also objects!

```typescript
// automatically uses type inference
var multiply = function(x: number) {
  return x * x;
};

// OR

// Defined to be a function using Function (capital)
var multiplyMore: Function;
// Defined as being set to be a function whose param is a number and returns a number
multiplyMore = function(x: number) {
  return x * x;
};

// Example
module something {
  var test = {
    x: 10,
    y: 20,
    calc: function() {
      return this.x + this.y;
    },
    // Using arrow function
    diff: (num1: number, num2: number) => num1 - num2;
  };
}
```
