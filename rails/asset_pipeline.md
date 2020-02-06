# Asset Pipeline

---

## Main Features

**First** feature is to concat assets to reduce the number of requests that a browser makes to render a web page. Browsers are limited in number of requests they can make so fewer the faster the application is.

Spockets concats all JS/CSS files into one big js/css file. Rails inserts a MD5 fingerprint into each file so it's cached by the browser.

- You can invalidate the cache by altering this fingerprint, which happens automatically whenever you change the file contents

**Second** feature is asset minification/compression.

- For CSS files, this is done by removing whitespace and comments.
- For JavaScript, more complex processes can be applied
  - Choosing from a pre-built config is possible or defining your own.

**Third** feature is that it allows coding assets via a higher-level language, with precompilation down to the actual assets.

- Sass for CSS, CoffeeScript for JavaScript, and ERB for both by default.

---

## Fingerprinting

Fingerprinting makes the name of a file dependent on its content. When the content changes, the name changes as well. In cases where infrequent change or static, this allows differentiation between two versions. Even between mutliple databases or deployment dates.

When a filename is unique and based on its content, HTTP headers can be set to encourage caches to keep their own copy of content

- Whether at CDNS, ISPs, or wherever

The technique sprockets uses for fingerprinting is to insert a hash of the content into the name typically at the end

An example CSS file would look like `global-908e25f4bf641868d8683022a5b62f54.css`

Pipeline assets can be placed inside an application in one of three locations: `app/assets`, `lib/assets` or `vendor/assets`.

- `app/assets` is for assets that are owned by the application, such as custom images, JavaScript files or stylesheets.

- `lib/assets` is for your own libraries' code that doesn't really fit into the scope of the application or those libraries which are shared across applications.

- `vendor/assets` is for assets that are owned by outside entities, such as code for JavaScript plugins and CSS frameworks.
