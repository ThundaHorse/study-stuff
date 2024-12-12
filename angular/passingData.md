# Passing Data between components in Angular

- Data can be passed using `Input` and `Output` decorators, services, or router state
- Lazy loading is a technique where feature modules are loaded on demand, reducing the initial load time of the application.

Example: Passing data from parent to child component using `@Input` decorator.

```jsx
// child.component.ts

import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html',
  styleUrls: ['./child.component.css'],
})
export class ChildComponent {
  @Input() childData: string; // Declare the input property
}

// child.component.html
<div>
  <p>Data from parent: {{ childData }}</p>
</div>;
```

```typescript
// parent.component.ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-parent',
  templateUrl: './parent.component.html',
  styleUrls: ['./parent.component.css'],
})
export class ParentComponent {
  parentData: string = 'Something';
}
```

```html
// parent.component.html
<div>
  <app-child [childData]="parentData"></app-child>
</div>
```

```typescript
// App.module.ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';
import { ParentComponent } from './parent/parent.component';
import { ChildComponent } from './child/child.component';

@NgModule({
  declarations: [AppComponent, ParentComponent, ChildComponent],
  imports: [BrowserModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
```

## Difference between @Input() and @Output() in Angular?

- `@Input()` lets a parent component update data in the child component.
- `@Output()` lets the child send data to a parent component.

| Decorator   | Purpose                                     | Example                                               |
|-------------|---------------------------------------------|-------------------------------------------------------|
| `@Input()`  | Pass data from parent -> child component    | `<child [childData]='parentData'></child>`            |
| `@Output()` | Emits events from child to parent component | `<child (childEvent)='parentMethod($event)'></child>` |