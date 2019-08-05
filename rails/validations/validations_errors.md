----------------
#  errors[]
----------------
We can use `errors[:attribute]` to see if a particular attribute is valid or not. 
  -> Returns an array of all errors for `:attribute`. 
    => Empty if no errors on specific attribute 

Only useful for after validations have been run, only inspects errors collection and doesn't trigger validations itself. 

It's different from `ActiveRecord::Base#invalid?` because it doens't verify the validity of the object as a whole. 
  -> Only checks to see whether there are errors found on an individual attr of 
     obj. 

To check error details of invalid attr, use `errors.details[:attribute]`. Returns an array of hashes with an `:error` key to get symbol of validator: 
```ruby 
class Something < ApplicationRecord
  validates :name, presence: true 
end 

>>> something = Something.new 
>>> something.valid? 
>>> something.error.details[:name] # => [{error: blank}] 
``` 

------------------------
# Validation Helpers 
------------------------
AR offers many pre-defined validation helpers that can be used inside class definitions. Helpers provide common validation rules, every time a fail, an error is added to obj's `errors` collection and its message associated with attr being validated. 

Each helper: accepts arbitrary # of attr names, with single line you can add same kind of validation to several attrs. 

All accept the `:on` and `:message` options. These define the validation shuold be run and what messages shuold be added to the `errors` collection if it fails respectively. 

`:on` takes on of the values, `:create` or `:update`. There's a default error for each one of the validation helpers
  -> These messages are used when `:message` option isn't specified 

-------------------------
#      Acceptance 
-------------------------
Acceptance validates that a cehckbox on the user interface was checked when a form was submitted. 

Typically used for: 
- When a customer needs to agree to ToS, confirm something, etc. 

```ruby 
class Something < ApplicationRecord 
  validates :terms_of_service, acceptance: true 
end 
``` 
Check is performed only if `terms_of_service` isn't `nil`. Default err is "must be accepted". 

For custom message, use `message` option: 
```ruby 
validates :terms_of_service, acceptance: { message: 'blah blah' }
end 
``` 
It can also receive an `:accept` option, determins the allowed values that will be considered as accepted. Defaults to `['1', true]`, easily changed. 
```ruby 
validates :terms_of_service, acceptance: { accept: 'yeet' }
end 
``` 

Validation is specific to web apps and 'acceptance' doesn't need to be recorded anywhere on DB. 
  -> If no field, helper will create a virtual attr. If it does, `accept` 
     option must be set to include `true` or else validation won't run 

That may be but you shouldn't forget you've got the whole package. The brains, beauty, attitude, and so much more so don't forget that, sorry if it was cheesy or not appropriate for right now.  

Erhm, that's a lot of stuff isn't it? I'm sure you'll do great, just maybe skim your cases if you have access lol.

--------------------------------------------
#  validates_associated & confirmation 
--------------------------------------------
Use `validates_associated` when mode has associations with other models that also need to be validated. 

What happens under the hood? 
• When you try to save your object, `valid?` will be called upon each one of 
  the associated objects. This will work with all association types. 
• Default error is "is invalid". Each associated obj will contain its own  
  `errors` collections, they don't bubble up to calling the model. 
```ruby 
class Library < ApplicationRecord
  has_many :books 
  validates_associated :books 
end 

# DON'T CALL ON BOTH ENDS OF ASSOCIATIONS. THEY'D CALL EACH OTHER IN AN INFINITE LOOP 
``` 

`confirmation` should be used when we have two text fields that receive exactly the same shit. i.e. email or password. Creates a virtual attr whose name is the name of the field that has to be confirmed with `_confirmation` appended. 
```ruby 
class Person < ApplicationRecord 
  validates :email, confiramtion: true 
  validates :email_confirmation, presence: true
  validates :email, confirmation: { case_sensitive: false }
  # ^ define whether or not confirmation constraint will be case sensitive.   
  # Defaults to true 
end 
```
view template should include: 
```
<%= text_field :person, :email %>
<%= text_field :person, :email_confirmation %> 
``` 
^ check is only performed if `email_confirmation` isn't `nil`. To require confirmation, add presence check for cnofirmation of attr. 


# Exclusion
Validates attr's values are not included in a given set. Can be any enumerable object. 
```ruby 
class Account < ApplicationRecord
  validates :subdomain, exclusion: { in: %w(www us ca jp), 
    message: "%{value} is reserverd." }
end 
``` 
`exclusion` has option `:in` that receives set of values that will not be accepted for validated attributes. 
  -> `:in` has an alias called `:within` we can use for same purpose. 
```ruby 
validates :legacy_code, format: { with: 'blah', 
message: 'only allows numbers' }
``` 
Alternatively can require specified attr doesn't match regex using `:without`. Default error is "is invalid". 

#Inclusion
Validates attrs' values are incldued in given set. Also has a helper that receives a set of values that will be accepted. 
```ruby 
validates :size, inclusion: { in: 'sdfsfs' },
  message: "%{value} is not a valid size" }
``` 

-----------------
#    Length 
-----------------

