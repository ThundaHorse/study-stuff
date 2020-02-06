# Caching and Internalization

<https://guides.rubyonrails.org/i18n.html>
Also contains translating views, field labels, error messages, strings and for localizing timestamps.

---

**I18n** (shorthand for internationalization) gem which is shipped with Ruby on Rails (starting from Rails 2.2) provides an easy-to-use and extensible framework for translating your application to a single custom language other than English or for providing multi-language support in your application.

**_"internationalization"_** usually means to abstract all strings and other locale specific bits (such as date or currency formats) out of your application.

- process of **_"localization"_** means to provide translations and localized formats for these bits.

It primarily focuses on the English language out of the box, however it can be customized and configured to work with other languages.

---

## Architecture of I18n

Rails adds all `.rb` and `.yml` files from the `config/locales` directory to the translations load path, automatically.

Made up of 2 parts

- The public API of the i18n framework - a Ruby module with public methods that define how the library works
  - The most important methods are:

```ruby
translate # Lookup text translations
localize # Localize Date and Time objects to local formats
```

These methods have aliases, `t` and `l`

```ruby
I18n.t # 'store.title'
I18n.l # Time.now
```

There are also attribute readers and writers for the following attributes:

```ruby
load_path                 # Announce your custom translation files
locale                    # Get and set the current locale
default_locale            # Get and set the default locale
available_locales         # Permitted locales available for the application
enforce_available_locales # Enforce locale permission (true or false)
exception_handler         # Use a different exception_handler
backend                   # Use a different backend
```

- A default backend (which is intentionally named Simple backend) that implements these methods

Typically, the public methods on the I18n module should be accessed, but it is useful to know about the capabilities of the backend.
