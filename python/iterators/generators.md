# Generators

---

Provide the means to describe iterable series with code and functions. **All generators are iterators**.
The sequences are **lazily evaluated**, meaning they only **compute** the **next value on demand**.

By doing so, this allows them to model infinite sequences of values with no definite end. They are also composable into pipelines for natural stream processing.

Generators are defined by any function that uses the `yield` keyword at least **once**.  
May also contain the `return` keyword with no argument.  
Like any other function, there's an implicit return at the end of the function.

```python
def gen123():
    yield 1
    yield 2
    yield 3

g = gen123()
g # <generator object gen123 at ..... >
next(g) # 1
next(g) # 2
next(g) # 3
next(g) # StopIteration exception
```

Because generators are iterators, they can be used in all the usual Python constructs which expect iterators, such as `for` loops.

```python
for i in gen123():
    print i
```

Each call to the generator function returns a new generator object, and have distinct addresses. Which means they can be advanced independently.

```python
h = gen123()
i = gen123()
h # <generator object gen123 at ....1>
i # <generator object gen123 at ....4>
h is i # false
```

---

## Stateful Generators

The resumable nature of generators can result in complex control flow. They can also maintain state in local variables and evaluate lazily, meaning they resme execution each time when the next value is requested.

Example in 'gen.py'

When execution starts, `distinct` must be called first in order to produce the argument for `take`.

`Distinct` returns the generator object over which `take` will be iterating in turn, the generator object returned by `take` will be iterated over by the for loop in the `run_pipeline()` driver.

When the outermost loop in `run_pipeline()` requests its first value, execution is transferred to `take`. The iterable over which `take` is looping is the generator produced by `distinct`.

When the for loop in `take` requests the first value from this generator, control is transferred to `distinct`. `distinct` now runs until it reaches the yield point, at which point it returns the first item from the source list.

The value is yielded back to the for loop in `take`, which executes until it in turn yields the value back to the loop in `run_pipeline,` which only now starts its first iteration.
