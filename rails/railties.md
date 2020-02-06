# Railties

---

`Rails::Railtie` is the core of the Rails framework and provides several hooks to extend Rails and/or modify the initialization process.

Every major component of Rails implements a Railtie. Each of them is responsible for their own initialization. -

- This makes Rails itself absent of any component hooks
  - allowing other components to be used in place of any of the Rails defaults.

Typically a Railtie is doesn't have to be utilized, but if the app needs to interact with the Rails framework during or after boot, then a railtie is needed.

Usually an app needing to do any of the following need Railties.

- creating initializers
- configuring a Rails framework for the application, like setting a generator
- adding `config.\*` keys to the environment
- setting up a subscriber with `ActiveSupport::Notifications`
- adding Rake tasks

---

## Creating a Railtie

To extend Rails using Railtie,

- create a subclass of `Rails::Railtie`.
  - This class must be loaded during the Rails boot process, and is conventionally called `MyNamespace::Railtie`.

```ruby
# This can be used with or without Railtie

# lib/my_gem/railtie.rb
module MyGem
  class Railtie < Rails::Railtie
  end
end

# lib/my_gem.rb
require 'my_gem/railtie' if defined?(Rails)
```

If wanting to utilize initializers

```ruby
class MyRailtie < Rails::Railtie
  initializer "my_railtie.configure_rails_initialization" do
    # some initialization behavior
  end
end
```

The block can also receive the application object, in case you need to access some application-specific configuration, like middleware:

Can also pass `:before` and `:after` as options to initializer, in case you want to couple it with a specific step in the initialization process.

```ruby
class MyRailtie < Rails::Railtie
  initializer "my_railtie.configure_rails_initialization" do |app|
    app.middleware.use MyRailtie::Middleware
  end
end
```

---

Railties can access a config object which contains configuration shared by all railties and the application:

```ruby
class MyRailtie < Rails::Railtie
  # Customize the ORM
  config.app_generators.orm :my_railtie_orm

  # Add a to_prepare block which is executed once in production
  # and before each request in development.
  config.to_prepare do
    MyRailtie.setup!
  end
end
```

If the railtie has Rake tasks, you can tell Rails to load them through the method `rake_tasks:`

```ruby
class MyRailtie < Rails::Railtie
  rake_tasks do
    load 'path/to/my_railtie.tasks'
  end
end
```

---

By default, Rails loads generators from load path. However, if you want to place your generators at a different location, you can specify in your railtie a block which will load them during normal generators lookup:

```ruby
class MyRailtie < Rails::Railtie
  generators do
    require 'path/to/my_railtie_generator'
  end
end
```
