# JSX: What is it? 

_jsx_ is a syntax extension for JavaScript. It looks a lot like HTML. 

What does 'syntax extension' extension mean? 

Means that JSX is not valid JavaScript! Web browsers can't read it. If a JS file contains JSX, has to be compiled. JSX compiler will translate it before the file reaches the web. 

A JSX attribute is written using HTML-like syntax: a name, followed by an equals sign, followed by a value. The value should be wrapped in quotes, like this:
``` bash
my-attribute-name="my-attribute-value"
```

You can nest JSX elements inside of other JSX elements, just like in HTML.

If a JSX expression takes up more than one line, then you must wrap the multi-line JSX expression in parentheses. This looks strange at first, but you get used to it:

Here’s an example of a JSX `<h1>` element, nested inside of a JSX <a> element:

```javascript
<a href="https://www.example.com"><h1>Click me!</h1></a>
```

OR

```javascript
(
  <a href="https://www.example.com">
    <h1>
      Click me!
    </h1>
  </a>
)
```

Nested JSX expressions can be saved as variables, passed to functions, etc., just like non-nested JSX expressions can! Here’s an example of a nested JSX expression being saved as a variable:

```javascript
const theExample = (
   <a href="https://www.example.com">
     <h1>
       Click me!
     </h1>
   </a>
 );
```

General Rule of Thumb: JSX Expression must have a exactly _one_ outermost element.

```javascript
const paragraphs = (
  <div id="i-am-the-outermost-element">
    <p>I am a paragraph.</p>
    <p>I, too, am a paragraph.</p>
  </div>
);
/// ^ Will work, V will not work

const paragraphs = (
  <p>I am a paragraph.</p> 
  <p>I, too, am a paragraph.</p>
);
```
_The first opening tag and the final closing tag of a JSX expression must belong to the same JSX element!_ 

