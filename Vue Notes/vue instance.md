# Creating a Vue Instance 

Every Vue app starts by creating a new _vue instance_ with `Vue` function. When creating a Vue instance, you pass in an _options object_. 
```javascript
// vm is short for ViewModel 
var vm = new Vue ({
  // options 
})
```
A Vue app consists of <b>root Vue instance</b> with `new Vue`. 

# Data and Methods 

When a Vue instance is created, adds all the properties found in its `data` object to Vue's <b>reactivity system</b>. 
When properties change, view will 'react', updating to match the new values. 

```javascript
var something = { a: 1 }
var vm = new Vue ({
  data: data 
})

vm.something == data.something // => true 

vm.a = 2 
data.a // => 2 
```

When data changes, the view will re-render. properties in `data` are only <b>reactive</b> if they existed when instance was created. 

If you add a new property, changes will not be trigger any view updates. 

Vue instances are prefixed with `$` to differentiate them for user-defined properties

```javascript
var data = { a: 1 }
var vm = new Vue ({
  el: '#example', 
  data: data 
})

vm.$data === data // true 
vm.$el === document.getElementById('example') // true 

vm.$watch('a', function(newVal, oldVal) {
  // callback will be called when 'vm.a' changes
})
```

# Instance Lifestyle Hooks 

Every Vue instance goes through series of initialization steps when it's created. Users can call `lifestyle hooks` to add their own methods at specific stages. 
  • Vue instance needs to set up data obs, compile template, mount instance to DOM, update DOM when data changes 

`created` hook can be used to run after an instance is created: 

```javascript 
new Vue ({
  data: {
    a: 1
  }, 
  created: function() {
    // 'this' points to vm instance 
    console.log('a is: ' + this.a); 
  }
})
// 'a is: 1' 
```

** Don't use `arrow functions`(fat arrow syntax) on options property or callbacks. Since arrow func doesn't have a 'this', 'this' will be treated 
as any other variable and lexically looked up through parent scopes until found.

```javascript
created: () => console.log(this.a) // or 
vm.$watch('a', newValue => this.myMethod())

// Usually results in errors.
Uncaught TypeError: Cannot read property of undefined or Uncaught TypeError: this.something is not a function`
``` 

![Life Cycle](lifecycle.png)
