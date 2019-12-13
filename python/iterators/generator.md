# Generator, not Generators

---

Generator expressions are s cross between comprehensions and generator functions. They create a generator object, are concise, and evaluate lazily.

The syntax is similar to list comprehension, except they use paranthesis instead of brackets.

`(expr(item) for item in iterable)`

Generator expressions are useful for situations where you want the lazy evaluation of generators with the declarative consisions of comprehentions.

Generators are single use objects. Each time we call a generator function, we create a new generator object.
To recreate a generator from a generator expression, we must execute the expression itself once more.
