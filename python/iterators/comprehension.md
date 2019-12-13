# Comprehension

---

## List Comprehension

Example 1

```python
word = "Hi there how are you".split()
words
# ["Hi", "there", "how", "are", "you"]
```

List comprehension is enclosed in square brackets just like a literal list.  
**However**  
Instead of elements, it contains **fragments** of declarative code which **describe how to construct the elements** of the list.

```python
# [expr(item) for item in iterable]
[len(word) for word in words]
# [2, 5, 3, 3, 3]
```

A new list is formed by binding word -> each value in words -> calculating the length of the word -> creates a new value.

---

## Set Comprehension

Similar to list comprehension, except uses { } instead of [ ].  
Sets are not necessarily stored in a meaningful order, since sets are **unordered collection of unique elements**.

`{ expr(item) for item in iterable }`

```python
from math import factorial

# List Comprehension
f = [len(str(factorial(x))) for x in range(10)]
# [1, 1, 1, 1, 2, 3, 3, 4, 5, 6]

# Set Comprehension
{ len(str(factorial(x))) for x in range(10) }
# { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
```

---

## Dictionary Comprehension

Like set comprehension, uses { }. However is distinguished by the fact that there are 2 colon seperated expressions.

`{ key_expr:value_expr for item in iterable }`

```python
country_to_capital = { 'United Kingdom': 'London',
                       'South Korea': 'Seoul',
                       'Sweden': 'Stockholm' }

# A nice use for dictionaries is inverting them for lookups in the opposite direction
capital_to_country = { capital: country for country, capital in country_to_capital.items() }
{ 'London': 'United Kingdom',
  'Seoul': 'South Korea',
  'Stockholm': 'Sweden' }
```

Dictionary comprehension does not usually operate directly on dictionary sources.  
**They can**,  
But iterating over a dictionary yields only keys.  
If key-value pair is desired, use the `item()` method and use **tuple unpacking** to access key and value seperately.

If the comprehension has identical keys, the later keys will overwrite the earlier keys.

```python
words = ["hi", "hello", "fun", "halo"]
{ x[0]: x for x in words } => { 'h': 'halo', 'f': 'fun' }
```

---

All 3 types of comprehension support an optional filtering clause.

`[ expr(item) for item in iterable if predicate(item) ]`

```python
from math import sqrt

def is_prime(x):
    if x < 2:
        return False
    for i in range(2, int(sqrt(x)) + 1):
        if x % i == 0:
            return False
    return True

# List
[x for x in range(5) if is_prime(x)]
# [2, 3, 5, 7, 11]

# Dictionary
prime_square_divisors = { x*x:(1, x, x*x) for x in range(5) if is_prime(x) }
# Maps numbers with exactly 3 divisors to a tuple of those divisors
# {
#   4: (1, 2, 4),
#   9: (1, 3, 9),
#   25: (1, 5, 25),
#   49: (1, 7, 49),
#   121: (1, 11, 121)
# }
```
