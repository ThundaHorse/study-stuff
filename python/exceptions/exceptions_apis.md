# Exceptions are a part of the API

---

Callers need to know what exceptions to expect and when.

## Exceptions are parts of 'families' of related functions. AKA `protocols`

## Avoid protecting against TypeErrors

Why?  
If a function works with a particular type, even one you couldn't have known about when designing, if it works it works. Otherwise execution will result in a TypeError anyways

## It's usually not worth checking types, this can limit your functions unnecessarily

```python
# This is a no-no, with a simple if statement this can be avoided
def sqrt(x):
    # if x < 0:
    #     raise ValueError("Cannot compute square root "
    #                       "of a negative number {}".format(x))
    guess = x
    i = 0
    try:
        while guess * guess != x and i < 20:
            guess = (guess + x / guess) / 2.0
            i += 1
    except ZeroDivisionError:
        raise ValueError()
    return guess
```

```python
def sqrt(x):
    guess = x
    i = 0
    while guess * guess != x and i < 20:
        guess = (guess + x / guess) / 2.0
        i += 1
    return guess

def main():
    print(sqrt(9))
    print(sqrt(2))
    try:
        print(sqrt(-1))
    except ZeroDivisionError:
        print("Cannot compute square root of a negative number.")
    print("Run as expected")

if __name__ == '__main__':
    main()
```

It is important to use exceptions that users will anticipate. Standard exceptions are often the best choice.

In order to examine the error, we have to modify exception handler to catch ValueError rather than ZeroDivisionError.

Modify calling code to catch the right exception:

```python
import sys

def main():
    try:
        print(sqrt(9))
        print(sqrt(2))
        print(sqrt(-1))
    except ValueError as e:
        print(e, file=sys.stderr)
```
