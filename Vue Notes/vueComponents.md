# In src folder, App.vue
Is a file handled by Vue loader handled by webpack, bundled together at the end
App.vue has 3 sections
• _Template_
• _Script_
• _Styles_

Convenient to split code over multiple files
.vue files are handled by webpack.config.js, 

# Components
When making a new component, give file name of what you want to name the component (best naming convention)
_TEMPLATE_ is always required

Templates always have _one_ root element 

```html
<!-- Message.vue -->
<template>
  <div>Something</div>
</template>
```

Can make a Vue.component via Vue.component but not in the file created, have to do it in main.js.
In main.js, 

```javascript
import Message from './Message.vue'; 
```

In Message.vue, no export. Webpack does it autonmatically in the background, transforms the code to JS and export it. 
With message imported, can use Vue.component('') 

```javascript 
Vue.component('app-message', Message); 
// Message is given from vue loader by compiling Message.vue. Otherwise configure an object {}
```

Can use the component in another file from the component created. 

```html
<template>
  <div id='app'>
    <app-message></app-message>
  </div>
</template>


<script>
  export default {
    data() {

    }
  }
</script>

<style>
</style>
```

Which renders 'Something' on an empty page at localhost:8080. 

Example of _Two-way-binding_, which allows you to pass data in and out at the same time. 
Alternatively, can use

v-bind:value='...' & v-on:input='...'

```html
<!-- Input.vue --> 
<template>
  <div>
    <!-- v-model binds input to a data property, which we need to export -->
    <input type="text" v-model="message">
    <!-- able to output because export default returns the data object-->
    <p> {{ message }} </p>
  </div>
</template>

<script>
// export default takes the data property and exports the object. 
  export default {
// KIND OF set up like a instance. 
// Able to use ES6 syntax because webpack automatically converts to ES5 
    data() {
      return {
// Return the data property, which then can be used in the <p> tags above. 
        message: ''
      }
    }
  }
</script>
```

Can register the component in main.js if wanting to use it globally, but if only applicable to a limited scope (certain files), 
specify within that file via a script tag.

```html
<!-- Message.vue --> 
...
<script>
// The exported object below needs an input, so we import a component to be used with the locally defined components 
import Input from './Input.vue'; 

// Export an object
  export default {
// Add local components 
    components: {
      'app-input': Input
// Keys are selectors ('app-input') ouput would be this component itself. 
    }
  }
</script>
``` 

This allows us to output 'app-input' 

```html 
<!-- Message.vue --> 
<template>
  <div>
    <h1>Message</h1>
    <app-input>Something</app-input>
    <!-- Whatever is input in the app-input tags, gets rendered in real time on the page --> 
  </div>
</template>
```

We're using this webpack setup, .vue files to contain each component in its own file to be used globally/locally