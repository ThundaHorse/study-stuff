# ASP.NET Core Working with Services and Dependencies

---

1. Inversion of Control

   - Inversion of Control delegates the function of selecting a concrete implementation type for a class's dependencies to an external component.

1. Dependency Injection
   - Dependency Injection is specialization of the Inversion of Control pattern. The Dep Injection pattern uses an object - the container - to initialize objects and provide the required dependencies to the object.

```cs
public class SomeController : Controller
{
  // Interface, not concrete implementation, just provides what it should look like
  private ILogger<SomeController>_logger;

  // Constructor injection. The constructor of the controller needs an instance of a type it implements.
  public SomeController(ILogger<SomeController>logger)
  {
    _logger = logger;
  }
}
```

The container then injects the dependency for the class. Leading to the class being decoupled from that responsibility and from that concrete type.

In ASP.NET Core, Dependency Injection is built in. ConfigureServices is used to register services with the built-in container.
