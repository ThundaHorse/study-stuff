# NestJS

---

## Main Components

- __Modules__: Way of organizing related components into a single block
- __Controllers__: Responsible for handling incoming `requests` & returning `responses`
  - Organize routes and handle HTTP requests
- __Services__: Responsible for business logic and interacting with data sources
  - Can be injected into controllers or other services

---

## @Body

- Decorated used to extract body of incoming `HTTP` request
  - Commonly used in methods that handle `POST/PUT`, where data is sent in body of request

---

## Interceptors

- Class annoted with `@injectable` & implements `NestInterceptor`
  - A function that can be used to intercept incoming request and perform some sort of manipulation before request is handled by route handler
    - Logging, authentication, etc.

---

## Pipes

- Allow validation or transformation of data before its passed to a route handler and can modify arguments as is, modify, or throw an exception

```typescript
@Injectable
class Something implements PipeTransform<string, number>
```

---

### Guards, Middleware

- Determine whether a given request will be handled by route handler or not present @ run-time
- Middleware is a function that's called before the route handler, has access to `request, response, and next()`

---

| Middleware                                                                                                                                                                  | Guards                                                                                                                                                                                                                                                                                                                                  | Interceptors                                                                                                                                                                        |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Operates like a pipeline that processes requests before they reach the route handler. __Generic__ and doesn't have specific knowledge about the route handler it's serving. | Primarily focus of autheorization, determing if a request should be handled by the route handler based on certain conditions. Access to execution context, allowing them to make decisions based on request metadata or custom logic. If a guard returns `false` or throws an exception, request is not processed by the route handler. | Provide ability to intercept and transform requests or responses before or after the route handler is called. Offer more control over request-response cycle compared to middleware |
| Logging, authentication checks, modifying the request object                                                                                                                | Primarily authorization                                                                                                                                                                                                                                                                                                                 | Logging, caching, modifying the response data                                                                                                                                       |

- In general, if you're working with HTTP requests and you need to add logic that doesn't modify the response sent to the client, middleware can be a good choice.
- If you need to add logic that applies to other types of transport such as WebSockets and microservices, or if you need to modify the response, use an interceptor.
