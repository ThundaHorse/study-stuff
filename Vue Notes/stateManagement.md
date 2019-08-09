
# State Management with Vuex

---

## Why use Vuex?

Typically used in medium to large scale apps that need to call actions or mutations to that state.

Gives us a __single__ source of truth.

When you don't use state with multiple components, information is that data is usually passed up by _emitting_ events passing it back down to other components via _props_.

Global state with Vuex is completely _reactive_. Which is kind of like a 'hive mind' concept. If one change happens, the others will be updated as well, at the same time.
\
Diagram of how Vuex manages state.
![State Management](stateManagementVuex.png)

Flow of events:

1. Vue component can dispatch an action (login, add, edit, etc.)
   - Request is sent to backend or whatever API currently being used.
2. Then commit a mutation, then it updates/mutates state in the way that is desired, then changes states and renders back to component.

### General Vuex Terms

- ___State___: App-level state/data. (todos, posts, etc)
- ___Getters___: Get pieces of state or computed values from the state
- ___Actions___: Called from components to commit a mutation
  - Changes are not made directly from actions, they are committed.
- ___Mutations___: Mutate the state (i.e. update)
- ___Modules___: Each module can have its own state, getters, actions & mutations (i.e. posts module, auth module, etc)

