# Overview

---

- Framework for building dynamic web apps.
  - Why?
    - Ease of use
    - Robustness
    - Modularity
- What is it?
  - A platform & framework for building client-side apps by extending HTML's syntax to express application components clearly and briefly
- Key features
  - 2-Way Data-binding
    - synchonizes data between model and view automatically
      - Data-binding expression `{{ something }}`
      - `{{ something }}` is bound with `ng-model='someting'`
      - `ng-model` can also provide
        - Type validation for app data
        - Provide status for app data
        - Provide CSS classes and bind HTML elements to HTML forms
  - Dependency Injection
    - Enhances modularity by managing and injecting dependencies efficiently
  - Modularization
    - Breaks down application in smaller and reusable modules
  - RESTFUL API Handling
    - Simplifies interaction with REST services and APIs
- Purpose of **@Component** Decorator
  - Defines a component by designating an Angular class and provides metadata about it
  - Template Association links a component with its HTML template (view)
  - Selector definition defines custom HTML tags that represent the component
  - Dependency Injection specifies providers for the component. Provides dependency injection
- Module **@NgModule**
  - A Container for cohesive group of components, directives, pipes and services
  - The purpose of NgModule in Angular is to organize an application into cohesive blocks of functionality by grouping related components, directives, pipes, and services.
  - **`NgModule`** defines a compilation context for these elements, providing modularity and maintainability.
    - ***Pipe***: A way to transform data in the template.
      - Angular provides built-in pipes like `DatePipe`, `UpperCasePipe`, and also allows custom pipes.

## Difference between Angular and AngularJS

| Feature        | Angular                                                | AngularJS                                    |
|----------------|--------------------------------------------------------|----------------------------------------------|
| Architecture   | Component-based architecture                           | MVC (Model-View-Controller)                  |
| Language       | TypeScript                                             | JavaScript                                   |
| Mobile Support | Designed with mobile support                           | Limited mobile support                       |
| Performance    | Higher performance with AOT compilation                | Relatively slower due to dynamic compilation |
| Data Binding   | 2-way data binding with reactive forms and observables | 2-way data binding with scopes and watchers  |

- ***AOT (Ahead of time compilation)***
  - Feature of the Angular framework that precompiles Angular applications before they are loaded in the browser. During the AOT compilation process, the application's templates and components are translated into optimized JavaScript code during the development phase.

### Differences between one-way-binding and two-way-binding

- **Property Binding**: Variables defined in the parent class can be inherited by child class that is templates in this case.
  - Only difference between `Interpolation` and `Property` binding is that non-string values should not be stored in variables while using interpolation.
    - If Boolean or other data types need to be stored, use `Property` binding.
  - **Interpolation Binding**: Used to display a component property in the respective view template with double curly braces syntax.
    - `{{ value }}`
    - Used to transfer properties mentioned in component class to be reflected in its template.

#### Digest Cycle in AngularJS

- The most important part of the process of data binding in AngularJS.
  - In AngularJS, the digest cycle was a core mechanism for two-way data binding.
  - However, in modern Angular (version 2 and above), the concept has evolved and is now referred to as `change detection`.
- Compares the old and new versions of the scope model and triggered automatically
  - If wanting to manually trigger cycle, use `$apply()`

| Feature     | AngularJS Digest Cycle                                                                                                                                                   | Angular Change Detection                                                                                                       |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Mechanism   | Uses digest cycle to track changes in the scope and update the view accordingly                                                                                          | Uses a more efficient change detection mechanism based on unidirectional data flow                                             |
| Trigger     | Triggered by events like user interactions, timers, or `$apply/$digest` calls                                                                                            | Triggered by events like user interactions, timers, asynchronous operations, or using the `ChangeDetectorRef` class            |
| Process     | Traverses scope tree, checking for changes in watched expressions. If detected, corresponding listener functions executed, cycle repeats until no more changes are found | Uses hierarchial change detection strategy. Change detection starts from root component and propogates down the component tree |
| Performance | Could become inefficient in large applications with complex data bindings                                                                                                | Significantly faster and more optimized than the AngularJS digest cycle                                                        |

##### Key Differences

- Data Flow: AngularJS uses bi-directional data flow, while Angular uses unidirectional data flow
- Efficiency: Angular's change detection is more performant than AngularJS digest cycle
- Triggering: Change detection in Angular is more granular and can be triggered manually or automatically

---

- if working with modern Angular
  - Don't need to worry about the digest cycle, focus on change detection mechanism

---

###### Purpose of the Signal API introduced in Angular 14+

- The Signal API allows tracking of reactive state changes and dependencies in Angular applications, enhancing reactivity and performance.

---

**Ivy** is a rendering engine, which means that Ivy takes templates (HTML) and transforms them into TypeScript (in simple terms).

- Starting from the ninth version release of Angular, the new compiler and runtime instructions are used by default instead of the older compiler and runtime, known as View Engine.

**JIT (Just in time)/AOT (Ahead of time)** are strategies for transforming generated TypeScript into JavaScript that can be read by the browser.

| **Feature**          | **AOT (Ahead-of-Time) Compilation**                                        | **JIT (Just-in-Time) Compilation**                                        |
|----------------------|----------------------------------------------------------------------------|---------------------------------------------------------------------------|
| **Compilation Time** | Compilation occurs at build time                                           | Compilation occurs at runtime                                             |
| **Performance**      | Faster startup time, as the code is already compiled                       | Slower startup time, as the code is compiled in the browser               |
| **Error Detection**  | Errors are detected at build time, allowing for earlier fixes              | Errors are detected at runtime, which may affect the user experience      |
| **Bundle Size**      | Smaller bundle size, as the compiler is not included in the bundle         | Larger bundle size, as the compiler is included in the bundle             |
| **Compatibility**    | Better suited for production environments, including server-side rendering | Often used in development environments for faster iteration and debugging |
