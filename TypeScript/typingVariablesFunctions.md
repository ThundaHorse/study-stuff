# Ambient Declarations and Type Definition Files

- External libraries are often used in development. One way to help Ts handle is with **static typing** and **abient declarations**.

When referencing a library, need to tell Ts that a library is being used.

```typescript
/// <reference path="__pathtofile/**.d.ts"/>
declare var ko: KnockoutStatic;
module demo {
  var name = ko.observable("something");
  var id = ko.observable(1);
  var person = {
    id: id,
    fullName: name
  };

  // Have to use parans because knockout wraps string value in a function
  var value: string = guy.fullName();
  console.log(value);
}
```

Ts uses typing files `*.d.ts` to determine the types that a Js library uses. By doing so, we can avoid debugging mistakes and compile-time checking.

---

## Any and Primitive Types

- Any represents any Js value. Any can represent any value at all. Can declare using `:any` or just ending with `;`. Basically the base type for all types in Javascript.
  - There is no static type checking on anything with any.

```typescript
var data: any;
var info;
```

- There are primitive types, which are all based off of `any`.
  - numbers
  - booleans
  - strings

```typescript
var age: number = 2;
var rating = 99; // Uses type inference to determine type number
```

## Arrays and Indexers

```typescript
var names: string[] = ["Abe", "Haemi", "Stella", "Nala", "Cayde"];

var leMe: string;
leMe = names[0]; // Can use this because names indexer knows it contains a string from var declared above.
```

## Primitive Types - Null

- Null can be used on any of the primitive types. Also applicable to object type as well.
  - It is a subtype of all primitives except `void` and `undefined`.
- Undefined type is a subtype of all types.

```typescript
// null
var num: number = null;
var str: string = null;
var person: {} = null;

// undefined
var love = undefined;
var height: number;
```

- Applying `!!` to a value will return a boolean of true or false.
  - ! negates returned value (truthy/falsy), and negates it again and infer whether or not it's a boolean.
