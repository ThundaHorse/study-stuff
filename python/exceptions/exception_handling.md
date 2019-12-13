# Exception Handling

---

Demonstrating Exceptions:

```python
def convert(s):
  '''Convert to an integer.'''
  x = int(s)
  return x
```

When running the above script, an error is raised.

```python
convert("hedgehog")
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
#   File "./xxxx.py", line 5, in convert
#     x = int(s)
# ValueError: invalid literal for int() with base 10: "hedgehog"
```

A way to make exception handling more robust is to use `try/except` blocks  
The `try` block contains code that can raise an exception.  
The `except` block contains code that contains error handling in event that an exception is raised.

```python
def convert(s):
  try:
    x = int(s)
  except ValueError:
    x = -1
  return x
```

Each `try` block can have multiple `except` blocks that intercept exceptions of different types.

```python
...
try:
  ...
except ValueError:
  ...
except TypeError:
  ...

OR

try:
  ...
except (ValueError, TypeError):
  ...
return ...
```

User-errors include the following, should not normally catch these types of errors.

- Indendation error
- Syntax error
- Name error

Keyword `pass` can be used in blocks to 'skip' an exception block.

```**python**
try:
  ...
except(ValueError, TypeError):
  pass
return ...

# Or when you want to get ahold of except value:
import sys
...

except(ValueError, TypeError) as e:
  print("conversion error: {}"\
        .format(str(e)),
        file=sys.stderr)
  return -1
# To print out to std window, need the sys module so import at the top
```

---

## Exceptions can not be ignored, but error codes can :3

Instead of returning an unpythonic error code, we can omit the error message and re-raise the exception object that is currently being handled.  
This can be done with the `raise` keyword.  
Without a parameter, `raise` re-raises the exception that is being handled

```python
def convert(s):
    try:
      return int(s)
    except (ValueError, TypeError) as e:
        print("Conversion error: {}".format(str(e)),
              file=sys.stderr)
        raise
```

## Try...Finally Construct

At times, a cleanup actions needs to be performed in respects to whether or not an operation succeeds.

```python
import os

def make_at(path, dir_name):
    original_path = os.getcwd()
    os.chdir(path)
    os.mkdir(dir_name) # If this fails,
    os.chdir(original_path) # This doesn't happen, the original working directory isn't restored
                            # Resulting in possible unintended side-effects

# To fix it, we want it to restore original working directory under all circumstances.
def make_at(path, dir_name):
    original_path = os.getcwd()
    try:
        os.chdir(path)
        os.mkdir(dir_name)
    finally: # Code in this block is executed no matter how the try block exits.
        os.chdir(original_path)
```

Can also be used in conjunction with except blocks.

```python
import os
import sys

def make_at(path, dir_name):
    original_path = os.getcwd()
    try:
        os.chdir(path)
        os.mkdir(dir_name)
    except OSError as e:
        print(e, file=sys.stderr)
        raise
    finally: # Runs even if OSError is thrown and handled
        os.chdir(original_path)
```

## Summary

- Raising an exception interrupts normal program flow and transfers control to an exception handler.
- Exception handlers defined using the `try...except` construct
- `try` blocks define a context for detecting exceptions. `except` blocks handle specific exception types.
- Python uses exceptions pervasively, many built-in language features depend on them.
- `except` blocks can capture an exception, which are often of a standard type. User-errors should not normally be handled
- Exceptional conditions can be signaled using `raise`. `rase` without an argument re-raises the current exception
- Exception objects can be converted to strings using `str()`
- A function's exceptions form part of its API, they should be documented properly.
- Use `try...finally` construct to perform cleanup actions. They can be used in conjunction with `except` blocks
