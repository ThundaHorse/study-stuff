# Iteration Protocols

---

Iterable Protocol:

- Iterable objects can be passed to the built-in `iter()` function to get an iterator.
  `iterator = iter(iterable)`

| Iterable Protocol                                                                      | Iterator Protocol                                                                          |
| :------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------- |
| Iterable objects can be passed into the built-in `iter()` function to get an iterator. | Iterator objects can be passed into the built-in `next()` function to fetch the next item. |
| `iterator = iter(iterable)`                                                            | `item = next(iterator)`                                                                    |

```python
iterable = ['Spring', 'Summer', 'Autumn', 'Winter']
iterator = iter(iterable)
next(iterator) # 'Spring' etc.
```

What happens when we get to the end? Python raises an exception, specificall `StopIteration`.

## Higher-level iteration constructs such as for loops and comprehensions are built directly upon this lower-level iteration protocol.
