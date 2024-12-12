# Directives

- Special markers on the DOM that tell Angular to do something to that DOM element or its children:
- Angular directives are extended HTML attributes with the prefix `ng-`

## ngIf

---

```html
<div *ngIf="showContent">
  This content will only be displayed if 'showContent' is true.
</div>
```

---

### ngFor

---

```html
<ul>
  <li *ngFor="let item of items">{{ item }}</li>
</ul>
```

---

### ngClass

---

```html
<div [ngClass]="{'active': isActive}">
  This div will have the 'active' class if 'isActive' is true.
</div>
```

---

### Creating new Directives

- In addition to built-in directives, you can create your own directives
- Created by using the `.directive` function
- To invoke new directive, make an HTML element with the same tag name as the new directive
- When naming, use camel case `somethingTestDirective` but when invoking, use `-` separated name, `something-test-directive`

```html
<body ng-app="myApp">
  <something-test-directive></something-test-directive>

  <script>
    var app = angular.module('myApp', []);
    app.directive('somethingTestDirective', function () {
      return {
        template: '<h1>Made by a directive!</h1>',
      };
    });
  </script>
</body>
```

- You can invoke a directive by using:

  - Element name `<something-test-directive></something-test-directive>`
  - Attribute `<div something-test-directive></div>`
  - Class `<div class="something-test-directive"></div>`
  - Comment `<!-- directive: something-test-directive -->`

- You can restrict your directives to only be invoked by some of the methods.

```javascript
var app = angular.module('myApp', []);
app.directive('somethingTestDirective', function () {
  return {
    restrict: 'A',
    template: '<h1>Made by a directive!</h1>',
  };
});
```

- Legal restrict values are:
  - `E` for Element name
  - `A` for Attribute
  - `C` for Class
  - `M` for Comment
- By default, the value is `EA`, meaning both element names and attribute names can invoke the directive

### Example

- Adding a custom behavior to an element, changing its background color on hover

```javascript
import { Directive, ElementRef, Renderer2, HostListener, Input } from '@angular/core';

@Directive({
    selector: '[appHoverBackground]'
})
export class HoverBackgroundDirective {
    @Input('appHoverBackground') hoverColor: string;

    constructor(private el: ElementRef, private renderer: Renderer2) { }

    @HostListener('mouseenter') onMouseEnter() {
        this.changeBackgroundColor(this.hoverColor || 'yellow');
    }

    @HostListener('mouseleave') onMouseLeave() {
        this.changeBackgroundColor(null);
    }

    private changeBackgroundColor(color: string) {
        this.renderer.setStyle(this.el.nativeElement, 'backgroundColor', color);
    }
}
```
