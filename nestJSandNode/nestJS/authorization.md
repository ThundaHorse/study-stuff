# How tokens are used for authorization in an API

---

- Tokens (JWT), used for authorization in API's to ensure that user has *permission* to access certain resources or performing certain actions.

- __Authentication__: Process of verifying the identity of a user.
  - When logging in, server verifies credentials and if valid, generates token.
    - Token contains info about user and is sent back to the client
- __Authorization__: Process of verifying what a user has access to
  - Once user is authenticated and token sent with each request, server can verify token and check if user has necessary permissions to perform requested action.

## Basic Process

1. User sends their credentials to server
2. Server verifies credentials and generates token if valid or not
3. In subsequent requests, client sends token in header of the request
4. Server verifies token and checks user's permissions

### Expiration time for tokens

- Expiry for tokens is important for security reasons.
  - If token is stolen or leaked, unauthorized access may be imminent
  - By setting expiration time, the time window in which a stolen token can be used is limited

---

### Token Refresh

- Stoken refresh strategy involves a refresh token when a user logs in
- Special kind of token that can be used to obtain a new access token when current one expires (Expires because JWT are stateless)
  - When a user logs in, along with access token, a refresh token is also generated and sent to the client
- When access token expires, client sends the refresh token to the server
  - Server then verifies the refresh token and issues a new access token
  - Allows user to stay authenticated without having to log in again, while limited potential damage of a stolen access token
- Typically have a longer expiry time than access token, can be revoked by the server if needed (logout)

### Implementing Token Refresh Strategy

- Issue a refresh token
  - When a user logs in, along with access token, issue a refresh token
  - Similar to how access tokens are issued, but typically with a longer expiration time
- Store the refresh token
  - Store refresh token in DB associated with user
  - Allows invalidation of the refresh token when necessary
- Create a refresh endpoint
  - Create an endpoint that accepts a refresh token and returns a new access token
    - Check that it hasn't been invalidated, and only then issue a new access token
- Use the refresh token
  - On client side, if 401 response, it means access token has expired
    - If so, send a request to refresh endpoint with the refresh token to get a new access token
    - Replace the old access token with the new one in client's storage

---

#### How does NestJS support authentication and authorization

- `Passport.js`: Integrates with `Passport.js`, popular authentication middleware for `Node.js`.
  - Main purpose is to facilitate authentication
  - Provides a way to implement different authentication stategies
    - local, JWT, OAuth, etc.
  - Provides set of tools that make it easier to implement authentication
- `JWT Module`: Nest provides JWT module for generating and validation JWT, which are commonly used for stateless, server-side authentication
- Guards: Classes that control whether a given request is allowed to proceed to the route handler, often used to implement authorization checks
- Decorators: Custom decorators can be used to provide metadata about routes, such as required roles for accessing a route
- Interceptors: Can be used to bind user data to the request based on the provided token
