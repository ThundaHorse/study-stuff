# Allowing User Input

- Form elements preserve React's rendering semantics
  - Binds state of user interface to state of model
  - Allowing users to input values would break React's model
- Form elements by themselves are read only
  - React's component state is a way to allow user input without breaking React's model

```javascript
class Identity extends React.Component {
  render() {
    return (
      <form>
        <input type="text" value="" placeholder="First Name" />
      </form>);
  }
}
```

- User cannot change content of text inputs
  
## Why?
Because input values are defined to be empty strings, _they cannot change_.

```javascript
// the input value is set to '', starts as empty string
<input type="text" value="" placeholder="First Name" />
// must always be empty string
```

## To allow a user to add input to a form
- Add state to the component containing the form.
  - Then bind the inputs to the component state.
  - This is important because the values of the inputs are bound to the state. They can change if the state changes.
- Final step is to use `onChange` event handler to catch user input and bind it to the component's state.
  - Because the content of the form is bound to the component state, when we change component state, we also change content of the form.

```javascript
// Updated form to allow user input
// Use class syntax to declare state
class Identity extends React.Component {
  constructor() {
    super();
    this.state = {
      firstName: ""
    };
// Have to bind the `onFieldChange` method to the class
// Necessary so that within onFieldChange we can access `this` and refer to the component
    this.onFieldChange = this.onFieldChange.bind(this);
  }

// Uses name of text input to update the state of the component using the `setState` method
  onFieldChange(event) {
    this.setState({
      // State for the name is set to input
      [event.target.name]: event.target.value
    });
  }

  render() {
    return (
      <form>
      // Difference is that value is bound to the properties of the component's state
      // We do so to allow values to change
      // Also have handler for `onChange` event as `onFieldChange`
        <input type="text" name="firstName" value={this.state.firstName} placeholder="First Name" onChange={this.onFieldChange} />
      </form>
    )
  }
}

ReactDOM.render(<Identity />, document.getElementById('root'));
```
