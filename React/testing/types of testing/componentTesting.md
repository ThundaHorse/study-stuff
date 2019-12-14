# Component Testing

Why component testing?

A way to test that:

- Output has not regressed
- Ensuring that rarely occurring corner cases produce the correct output
- If a component genereates side effects, verify that they occur but don't execute them
- Verify user interactions are handled as expected

Components may or may not have lifecycle handlers and may or may not have internal state. Additionally, they may or may not generate side effects and may get state from arguments or external dependencies.

## Building a Testable React component

Characteristics of components that are easiest to test:

- No internal state
  - Output is an idempotent product of props passed in
- No side-effects
  - Any AJAX calls or UI changes or other side effects are handled by sagas or thunks
- No lifecycle hooks
  - Fetching data is handled at app level, not component level
