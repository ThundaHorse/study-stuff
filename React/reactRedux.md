
# React-Redux

---

React-Redux is an extra module that helps with the integration of React and Redux. It can add some useful features and make code neater.

It is important to know what each does before understanding the combining of the two.

---

__The__ main service provided by React-Redux is to connect React components to the application state.

- `provider`: Component provided by React-redux. When it's included in a React application, it enables ___all___ React components below it in the component tree to connect to the Redux store.
- `connect`: Function provided by React-redux that enhances React components by connecting them to the Redux store in the ways specified:
  - To specify what data from the Redux store should be provided to the React component as a prop, connect expects a parameter called:
    - `mapStateToProps`: A function from the Redux store to a set of props for the component.
      - Takes care of getting data from the store to the component.
    - `mapDispatchToProps`: Takes care of specifying how the component can send actions to the Redux store. It is a function from Redux's dispatch function to a set of props for the component.
      - In practice, this provides a place to map component events to Redux store actions.
