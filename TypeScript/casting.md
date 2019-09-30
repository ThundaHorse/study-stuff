# Casting Types

Casting, AKA converting between types.

```typescript
// Fails, this returns an html element, not an html table
var table: HTMLTableElement = document.createElement("table");
``;

// Casting as html table element to create table
var table: HTMLTableElement = <HTMLTableElement>document.createElement("table");
```

The `<>` tells Ts that we want to convert between an HTML element and an HTML Table element.

In order to use, important to use `lib.d.ts` file. It is an out-of-the-box DOM and Js file.

Typescript file

```typescript
class Test {
  private x: HTMLInputElement;

  constructor(xId: string) {
    this.x = <HTMLInputElement>document.getElementById(xId);
  }
}
```

HTML File

```html
<div>X: <input type="text" id="x" />&nbsp;</div>
```

^ Typescript targets HTML input element with id of "x".
