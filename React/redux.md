
# Redux

---

It isn't necessary to have a state container. Conversely, it isn't too difficult to build one. However there are some advantages to using a common state container library.

Advantages include:
- A degree of standardization
  - If many apps can use the same library, it's often less important what the standard is, then that there is a standard.
- Implementation is likely to be more robust and have more features.

## What is Redux?

Redux is a popular and quality state container. It provides a good basis for implementing the MVI architecture.

It can be super simple or pretty sophisticated.

In the stopwatch app example, the state container used a function that converted the current state and an intent to a new update state.

In Redux, this function is called a __reducer__, because it reduces the stream of intents into a single object.

- The Application state at a moment in time.

Intents were referred to as trigger state changes. Because that's what they are in context to MVI.
Redux refers to 'intents' as __actions__.

intent = action

---

## Redux API

---

- `createStore(reducer, initialState)`: The function used to create a new store, the container for the application state.
  - To create a store, we supply a reducer function and the initial store state.
- `getState()`: Returns the current application state from within the store.
- `dispatch()`: Sends an action to the store to be applied to the current state.
  - The action is processed by the reducer function which builds a new application state.
- `subscribe()`: Registers a callback to be called when the application state held within the store changes.

---

# Stopwatch using Redux

---

The first change will be to delete the `createStore()` function and replace it with Redux's. However doing so will __break__ the application, the console error will be as follows: 

```
Error: Actions must be plain objects. Use customer middleware for async operations.
```

This is a Redux convention that essentially says that actions should be objects, in the code below they are currently strings. Additionally (optional, but typically the way Redux is used), objects should have a property called `type`.

Stopwatch code:

```javascript
// Original code
// const update = (model = { running: false, time: 0 }, intent) => {
// Redux code
  const update = (model = { running: false, time: 0}, action) => {
  const updates = {
    'START': (model) => Object.assign(model, {running: true}),
    'STOP': (model) => Object.assign(model, {running: false}),
    'TICK': (model) => Object.assign(model, {time: model.time + (model.running ? 1 : 0)})
  };
// Original code  
  // return (updates[intent] || (() => model))(model);
// Redux code 
  return (updates[action.type] || (() => model))(model);
};

let view = (m) => {
  let minutes = Math.floor(m.time / 60);
  let seconds = m.time - (minutes * 60);
  let secondsFormatted =  `${seconds < 10 ? '0' : ''}${seconds}`;
  let handler = (event) => {
// Original code
    // container.dispatch(m.running ? 'STOP' : 'START');
// Redux code
    container.dispatch(m.running ? {type: 'STOP'} : {type: 'START'})
  };
  
  return <div>
    <p>{minutes}:{secondsFormatted}</p>
    <button onClick={handler}>{m.running ? 'Stop' : 'Start'}</button>
  </div>;
};

// const createStore = (reducer) => {
//   let internalState;
//   let handlers = [];
//   return {
//     dispatch: (intent) => {
//       internalState = reducer(internalState, intent);
//       handlers.forEach(h => { h(); });
//     },
//     subscribe: (handler) => {
//       handlers.push(handler);
//     },
//     getState: () => internalState
//   };
// };

let container = createStore(update);

const render = () => {
  ReactDOM.render(view(container.getState()),
    document.getElementById('root')
  );
};
container.subscribe(render);

setInterval(() => {
// Original code
  // container.dispatch('TICK');
// Redux code
  container.dispatch({type: 'TICK'});  
}, 1000);
```

Because the API was similar, the changes from original to Redux was using Redux's `createStore()` function, and to convert actions to objects, instead of strings.

Redux version: 

```javascript
const update = (model = { running: false, time: 0}, action) => {
  const updates = {
    'START': (model) => Object.assign(model, {running: true}),
    'STOP': (model) => Object.assign(model, {running: false}),
    'TICK': (model) => Object.assign(model, {time: model.time + (model.running ? 1 : 0)})
  };
  return (updates[action.type] || (() => model))(model);
};

let view = (m) => {
  let minutes = Math.floor(m.time / 60);
  let seconds = m.time - (minutes * 60);
  let secondsFormatted =  `${seconds < 10 ? '0' : ''}${seconds}`;
  let handler = (event) => {
    container.dispatch(m.running ? {type: 'STOP'} : {type: 'START'})
  };
  
  return <div>
    <p>{minutes}:{secondsFormatted}</p>
    <button onClick={handler}>{m.running ? 'Stop' : 'Start'}</button>
  </div>;
};

let container = createStore(update);

const render = () => {
  ReactDOM.render(view(container.getState()),
    document.getElementById('root')
  );
};
container.subscribe(render);

setInterval(() => {
  container.dispatch({type: 'TICK'});  
}, 1000);
```
