# Routing

---

## Member collection routes

When needing to add more actions to a RESTful resource, use `member` and `collection` routes.

```ruby
resources :trips do
  get 'tickets', on: :user
end
```

When needing to define multiple `member`/`collection` routes use the alternative block syntax.

```ruby
resources :trips do
  user do
    get 'tickets'
    # more routes
  end
end

resources :photos do
  collection do
    get 'search'
    # more routes
  end
end
```

## Nested Routes

Primarily used to express the relationships between Active Record models

```ruby
class User < ActiveRecord::Base
  has_many :photos
end

class Photo < ActiveRecord::Base
  belongs_to :user
end

# routes.rb
resources :users do
  resources :photos
end
```

## Shallow Routes

When needing to nest routes more than 1 level deep, use the `shallow: true` option. This saves the user from long URLs `posts/1/comments/5/versions/7/edit` and you from long URL helpers `edit_post_comment_version`.

```ruby
resources :users, shallow: true do
  resources :photos do
    resources :collections
  end
end
```
