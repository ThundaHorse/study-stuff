# Classes

---

Classes define the structure and behavior of objects. An object's class controls its initialization.

**Methods** are functions defined within a class.
**Instance methods** are functions which can be called on objects.
**Self** is the first argument to all instance methods.

`__init__()` is an initializer, not a constructor.
By convention, implementaion details start with underscore.

```python
class Flight:
    def __init__(self, number):
        self._number = number
    def number(self):
        return self._number

>>> f = Flight("Something")
>>> f.number()
# 'Something'
```

It's good practice for the initializer of an object to establish class invariants. Invariants are truths about an object that endure for its lifetime.

---

## Inheritence

---

Inheritence is a mechanism whereby one class can be derived from a base-class. By inheriting, it makes its behavior and making behavior specific to the sub-class.

Python uses `late binding`, no python calls or attribute lookups are bound to actual objects until the point at which they are called.

---

## Law of Demeter

Object-Oriented design principle that states you should never call methods on objects you receive from other calls.

- "Only talk to your friends"

---

## Polymorphism and Duck Typing

---

- ___Polymorphism___: programming language feature that allows use of objects of different types through a uniform interface.
  - Concept applies to functions and more complex objects
  - Achieved in Python through __duck typing__:
    - An object's fitness for purpose is determined at the time of use.

Duck typing and Polymorphism are the basis for the collection protocols such as iterator, iterable, and sequence.

Inheritance is most useful for sharing implementaion in Python.

```python
class Something:
    def something(input):
        thing1, thing2 = self.some_func()
        return len(thing1) * len(thing2)

class Thing(Something):
    def __init__(self, value):
        self.value = value
...
```