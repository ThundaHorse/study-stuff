# Validations and Callbacks

---

During normal use of a Rails app, objects can be updated/deleted/created/etc. (CRUD).
Active Record provides hooks into this object life cycle so that you can control your application and its data.

- Callbacks and observers allow you to trigger **_logic before or after an alteration of an object’s state._**

Validations are important because it ensures that only **_valid data is stored in the database._** There are many ways to go about validation, including native _database constraints_, _client-side validations_, _controller-level validations_, and _model-level validations_.

- **Model-level validations**: are the best way to ensure that only valid data is saved into your database. They are database **_agnostic_**, cannot be bypassed by end users, and are convenient to test and maintain.
  - Rails makes them easy to use, provides built-in helpers for common needs, and allows you to create your own validation methods as well.
- **Database contraints**: make the validation mechanisms database-dependent and can make testing and **maintenance more difficult**. However, if your database is used by other applications, it may be a good idea to use some constraints at the database level.
  - Additionally, database-level validations can safely handle some things (such as uniqueness in heavily-used tables) that can be difficult to implement otherwise
- **Client-side validations**: can be useful, but are generally unreliable if used alone.
  - If they are implemented using JavaScript, they may be bypassed if JavaScript is turned off in the user’s browser. However, if combined with other techniques, client-side validation can be a convenient way to provide users with immediate feedback as they use your site.
- **Controller-level validations**: can be tempting to use, but often become unwieldy and difficult to test and maintain.
  - Whenever possible, it’s a good idea to keep your controllers **skinny**, as it will make your application a pleasure to work with in the long run.

---

There are 2 types of `ActiveRecord` objects.

1. Those that correspond to a row inside your database
2. Those that do not

When creating a new object, `.new` is called, it isn't saved to database until `.save` is called. Active Record uses the `new_record?` instance method to determine whether an object is already in the database or not.

If validations are not carefully constructed, it is possible to save an invalid object which may break things in the application.

These methods trigger validations and will save the object to the database **_ONLY_** if the object is valid:

- create
- create!
- save
- save!
- update
- update_attributes
- update_attributes!

The bang versions raise an exception if the record is invalid.
`save` and `update_attributes` return false, `create` and `update` just return the objects

---

## Skipping Validations

The following methods skip validations, and will save the object to the database regardless of its validity.

```ruby
decrement!
decrement_counter
increment!
increment_counter
toggle!
touch
update_all
update_attribute
update_column
update_counters
```

`save` also has the ability to skip validations if passed `:validate => false` as argument.

`save(:validate => false)`

---

<https://guides.rubyonrails.org/v3.2/active_record_validations_callbacks.html>

`errors[:attribute]` can be used to verify whether or not a particular attribute of an object is valid. The returned value is an array of all the errors for `:attribute`, obviously if no errors an empty array will be returned. This method is only useful **after** validations have been run, because it only **inspects the errors collection** and **does not trigger validations itself**.
