# Snapshot Testing

A Snapshot is a JSON-based record of a component's output. It is a representation of what your code looked like when the snapshot was taken.

During the test, JEST compares the JSON file to what is actually output by the component during the test. If everything matches, passes otherwise fails.

These tests are committed along with other modules and tests to the repo.

---

| Advantages                                                                                                                          | Disadvantages                                                                                     |
| ----------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| Fast & Automatic                                                                                                                    | Easy to ignore and protects only against regression                                               |
| Catches regressions we may miss and works nicely with libraries that take in state and output HTML components (React, Vue, Angular) | If component is working incorrectly and is then fixed, snapshot test will now say it's broken     |
| Adds some protection against regression when short on time and easy to learn                                                        | Adds extra files, sensitive to changes, waste of resources if component is certain to be modified |

---

## How Snapshot Testing Works

1. The component is imported as well as the `renderer` from `react-test-renderer`.
1. Use the renderer's `.create` method to create something called a **tree**
   - The tree is essentially a representation of the HTML output of the component.
1. The first time `toMatchSnapshot()` is called, a snapshot is created. Each subsequent time, a new snapshot is compared with the old one.
1. To update a snapshot after components have changed, run with `--update` flag.
   - Old snapshots will be replaced with 'image' of current output. But using `--update` without consideration diminishes the value of snapshots

```javascript
// Some component
import React from "react";

export default class TestComponent extends React.Component {
  render() {
    return (
      <div className="container">
        <h1>Test Header</h1>
      </div>
    );
  }
}

// spec
import React from "react";
import TestComponent from "path-to-component";
import renderer from "react-test-renderer";

describe("The header", () => {
  it("has a h1 tag", () => {
    const tree = renderer.create(<TestComponent />).toJSON();

    expect(tree).toMatchSnapshot();
  });
});
```

What would be saved in the snapshot would be:

```javascript
// src/__snapshots__
// Jest Snapshot ...
exports["has a h1 tag"] = `
  <div>
    <h1>Test Header</h1>
  </div>
`;
```
