# Client-side Routing with HTML5 pushState

---

- HTML5 includes an API called `pushState` or `history` to allow JavaScript to update the browser URL without triggering a request to the server.
- An application running in the browser can cause the URL to change, then detect that change and handle it.
  - It a user modifies the Url, that too can be detected.
- A plus for `pushState` for routing is that Urls are indistinguishable from normal Urls used with servers-side apps. 
  - Implemented properly, this enables proper refresh behavior, bookmarking, and back button.
- Because the Urls are proper Urls, the server needs to be able to respond to the request being made.
  - One technique is to have server return same page for all requests and then let routing happen client side.

## React Router

- Most popular client-side router for React.
- Provides conditional rendering based on routes. 
  - When a route is requested, React Router can take care of rendering the correct component.
  - Also supports route parameters
  - Also provides a way to update the current URL path which in turn triggers the router to update the UI to match.

## The Route Component 

``` javascript 
// If exact is specified, then the path is only matched
// if the current location is an exact match for the path prop
<Route exact path='/'component={Welcome} />
// If exact is not specified, then the match is more of a 'begins with'
```

You place a route element somewhere in your application with a _path_ prop and _component_ prop.
If the current URL matches the path specified, then the component specified is rendered at that location.

### Path Params

```javascript
// :id is a variable and supplied to the component Single
<Route path='/single/:id' component={Single} />

// The Single component receives a match prop
function Single({match}) {
// Match prop has a params object which contains any path params
  return <div>{match.params.id}</div>;
}
```

A more complete example of a React Router

```javascript
ReactDOM.render(
  <BrowserRouter>
    <section id="navigation">
// Will match any path, which is redundant
// Could potentially be replaced with something more meaningful
      <Route path='/' component={Menu} />
    </section>
    <section id='detail'>
// If path is exactly a '/', then welcome component is rendered
      <Route exact path='/' component={Welcome} />
// If the route starts with '/list' then the list component is rendered
      <Route path='/list' component={List} />
// If the route starts with '/single/something'
// Then the single component is rendered and 'id' param supplied
      <Route path='/single/:id' component={Single} />
    </section>
  </BrowserRouter>, document.getElementById('app'));
```

Each route attempts to match their path prop to the current route path. If they match, then they render their component.
Where `route` elements occur, there must be a `BrowserRouter` element somewhere higher in the component tree.
  • This is due to how React Router is implemented, not a logical requirement.
