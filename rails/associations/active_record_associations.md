--------------------
#  Associations? 
--------------------
What is it? A link between two Active Record Models. 
Why? They make common operations simpler and easier in code 
Without them, model declarations would be pretty messy 

With AR associations, we can declaratively tell Rails that there is a connection between 2 models. 
```ruby 
class Author < ApplicationRecord 
  has_many :books, dependent: :destroy 
end 

class Book < ApplicationRecord 
  belongs_to :author 
end 
``` 
With ^, creating a new book is easy 
```ruby 
@book = @author.books.create(published_at: Time.now)
# Deleting 
@author.destroy 
``` 

-------------------------
# Types of Associations 
-------------------------
There's 6 types of associations: 
```ruby 
• belongs_to 
• has_one, has_many
• has_many :through, has_one :through 
• has_and_belongs_to_many
``` 
Associations are implemented using macro-style calls, so we can declaratively add features to models. a Primary-key / Foreign-Key relationship. 

# The 'belongs_to' Association 
Sets up a one-to-one connection with another model. Each instance of the declaring model 'belongs' to one instance of the other model.  
```ruby 
class Book < ApplicationRecord 
  belongs_to :author 
end 
``` 
-> If app includes authors and books, each book can be assigned to exactly one 
   author.
These associations must be singular. If you use pluralized form, there's an error. 

