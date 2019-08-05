# new Vue 
When declaring 'new Vue', typically the root Vue instance that the rest of the app descends from. 
This hangs off the root element declared in html doc. 

new Vue ({
  el: '#app',
  data () {
    return {} 
  }
})

```html 
<html>
  <body>
    <div id='app'></div>
  </body>
</html>
```
The 'div' tag is the start of the app, Vue is applied to everything else inside it.

# export default 

Can be declared using a component, which can be registered and reused. 

// filename.js 
export default {
  name: 'my-component', 
  data () {
    return {}
  }
}

After creating a component, can be used later in another file 

```html
<!-- another-one.js --> 
<template>
  <my-component></my-component>
</template>

<script>
  import myComponent from 'my-component'
  export default {
    components: {
      myComponent 
    }
    data () {
      return {} 
    }
  }
</script>
```

Important to decalre `data` properties as functions, otherwise they're not going to be reactive. 