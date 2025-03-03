# React.js Interview Questions

---

## Advantages of React?

- Increases the apps's performance with the Virtual DOM
- JSX makes code easy to read and write
- Renders both on the client and server-side
- Since it's a view library, easy to integrate with other frameworks (Angular, BackboneJS)

***Works by***

- Creating a virtual DOM
  - When state changes in a component, it first runs a "diffing" algorithm
    - Identifies what has changed in the virtual DOM.
    - Then reconciliation --> updates the DOM with the resulsts of the difference

***What are `refs`***

- **`refs`** provide a way to access DOM nodes or React elements created in the render method
  - Should typically be avoided but they can be useful when we need to direct access to the DOM element or an instance of a component.

Use cases ***for***:

- Managing focus, text selection, or media playback
- Triggering imperative animations
- Integrating with 3rd party DOM libraries

Refs are created using `React.createRef()` or `useRef` and attached to React elements via the `ref` attribute. Commonly assigned to an instance property when a component is constructed so they can be referenced throughout the component.

### Context API in React

- Context provides a way to pass data through the comonent tree without having to pass props down manually at every level.

- Designed to share data that can be considered "global" for a tree of React components. Such as current authenticated user, theme, or preferred language.
  - Eliminates the need for passing props through intermediate elements.

```jsx
const ThemeContext = useContext('light')

const App = () => {
  render() {
    // Use a Provider to pass the current theme to the tree below.
    // Any component can read it, no matter how deep it is.
    // In this example, we're passing "dark" as the current value.
    return (
      <ThemeContext.Provider value="dark">
        <Toolbar  />
      </ThemeContext.Provider>
    )
  }
}

// A component in the middle doesn't have to
// pass the theme down explicitly anymore.
function Toolbar() {
  return (
    <div>
      <ThemedButton />
    </div>
  );
}

const ThemedButton = () => {
   // Assign a contextType to read the current theme context.
  // React will find the closest theme Provider above and use its value.
  // In this example, the current theme is "dark".
  const contextType = ThemeContext;

  render() {
    return <Button theme={contextType}  />
  }
}

```

#### Difference between `state` and `props`

- ***state*** is a data structure that starts with a default value when a component mounts.
  - Can be mutated across time, mostly due to user events
- ***props*** are component's configuration.
  - Received from above and are `immutable` as far as the component receiving them is concerned.
  - Component cannot change its props, but it is responsible for putting together the props of its child components.
    - Can pass in callback functions
