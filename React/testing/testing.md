# Testing React with Jest

---

Can label test files either `spec.js` or `test.js`, grouping is loose, can either pair test files under file it's testing or in separate folder.

`beforeAll` is used to run code before all tests, `afterAll` is used to run after all tests. `beforeEach` is used to execute code before each test, `afterEach` is used to do something after each.

## Async Testing

Async tests contain assertions (like regular tests), however they don't complete instantaneously.

- Can take varying amount of time depending, because of this, Jest must be notified that a test is complete

There are a few ways to define async tests:

1. Invoke the `done()` callback that is passed to the test
1. Return a promise from a test.
1. Pass an async function to `descrcribe`

These tests do roughly the same thing, just show different formatting for async tests.

```javascript
// Done callback
it("async test 1", done => {
  setTimeOut(done, 100);
});

// Returning a promise
it("async test 2", () => {
  return new Promise(resolve => setTimeout(resolve, 100));
});

// Passing an async function
// Delay is a method that returns a promise
it("async test 3", async () => await delay(100));
```

---

## Mocking

- Mocking reduces the number of dependencies required by tests (faster execution).
- Prevent side-effects during testing
- Can also be used to faciliate custom mocks to test desired procedures.

**What is a mock?**

A mock is a convincing duplicate of an object with no internal workings. They can be automatically or manually created and have the same API as the original, but no side-effects. They also spy and simplify testing.

## The mocking process

Mocks scan the original object for methods, give the new object spy methods with the same names.

Additionally, they ensure that any methods which returned a promise still return a promise in the mock. They also create mocks for any complex values that are returned from methods which are required for tests.

## Mock Functions

Mock functions are also known as spies, have no side-effects, and counts function calls. They also record arguments passed when called, can be "loaded" with return values (mock return), and return value must approximate the original.

## Creating Mock Files

Appropriately named NPM mocks are loaded automatically, however the must reside in a `__mocks__` folder next to mocked module. NPM modules and local modules can both be mocked.

- Usually at top level of the app, next to `node_modules`

What happens is that if there is a file in the `__mocks__` folder that is adjacent to npm modules has the exact same name as the npm module, it will be loaded instead of the whole npm module.

For example, if testing something that fetched data, it could be set up like this:

```javascript
// testFn.js
...
export function * handleFetchQuestion({question_id}) {
  const raw = yield fetch(`/api/question/${question_id}`);
  const json = yield.raw.json();
  const question = json.items[0];

  yield put({type: `FETCHED_Q`, question})
}

// app > __mocks__
const id = 42

// spec
describe("", () => {
  it("", () => {

  })
})

```
