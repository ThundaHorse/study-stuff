# <center>Framework Fundamentals</center>

---

## Command line commands, setting up a project, conventions

---

## Configuration

---

### Initializers

<https://github.com/rubocop-hq/rails-style-guide>

#### Config

- Put custom initialization code in `config/initializers`. The code in initializers executes on application startup

#### Gem

- Keep initialization code for each gem in a separate file with the same name as the gem
  - for example `carrierwave.rb`, `active_admin.rb`, etc.

#### Dev/Test/Prod Configs

- Adjust accordingly the settings for development, test and production environment (in the corresponding files under `config/environments/`
  - Mark additional assets for precompilation (if any):

```ruby
# config/environments/production.rb
# Precompile additional assets (application.js, application.css,
#and all non-JS/CSS are already added)
config.assets.precompile += %w( rails_admin/rails_admin.css rails_admin/rails_admin.js )
```

#### App configs

- Keep configuration that’s applicable to all environments in the config/application.rb file.

#### Staging configs

- Create an additional `staging` environment that closely resembles the `production` one.
- Primarily for 'staging' a pseudo production environment. Can use same databases if wanted, just different settings (asset management, logging, 3rd party services) or the same config with a different database.

To create a new environment, 3 requirements

1. `config/environments/YOUR_ENVIRONMENT.rb`
2. a new database configuration entry in `config/database.yml`
3. a new secret key base entry in `config/secrets.yml` for apps on Rails 4.1 and higher, `rake secret` to create a new secret key
   - various initializers that might be configured for specific environments need to be configured

```ruby
# config/initializers/rack_profiler.rb
if Rails.env.development? || Rails.env.staging?
  require 'rack-mini-profiler'

  # Initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)

  # Needed for staging env
  Rack::MiniProfiler.config.pre_authorize_cb = lambda { |env| true }
  Rack::MiniProfiler.config.authorization_mode = :allowall
end

# Now prepending commands is possible with new RAILS_ENV values
RAILS_ENV=staging rake db:create
```

#### YAML Config

- Keep any additional configuration in YAML files under the `config/` directory.
- Since Rails 4.2 YAML configuration files can be easily loaded with the new `config_for` method:

```ruby
Rails::Application.config_for(:yaml_file)
```
