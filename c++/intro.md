# C++

---

C++ is often used because it is so efficient and power efficient. Can be used in a lot of things such as small pieces of jewelry that displays something or larger sclae apps, phone apps, games, desktop apps.

There is a standard for C++, isocpp.org.

Typically, you just need a _compiler_, _IDE_, and _debugger_.

Building typically looks like:
cpp -> (compile) -> obj -> (link) -> exe

Example C++ snippet:

```cpp
// include directives that bring in code from elsewhere we can use
# include <iostream>
# include <string>

// All console apps have a function called main, regardless of platform
int main()
{
  std::cout << "Type ya name" << std::endl;
  std::string name;
  std::cin >> name;
  std::cout << "Hello" << name << std::endl;

  return 0;
}
```
