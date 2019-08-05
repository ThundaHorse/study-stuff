-----------------------------
# Problem: 
How can we make ActiveRecord scope all queries the same way by default? 

-----------------------------

# Solution: 
We can set default criteria for model operations using Active Record's 'default_scope()' method. 

-----------------------------
Active Record has a tool called 'default scopes'

```ruby 
# rr2/default_scopes/app/models/product.rb 
class Product < ActiveRecord::Base 
  default_scope :available, where(:available => true) 
end 
``` 
Result 
``` 
> Product.all.map &:available 
=> [true, true, true, true, true] 
> Product.connection.execute("select count(*) from products") 
=> [{"count(*)"=>11, 0=>11}] 

lb = Product.create(:name => "blah", :price => 20) 
=> #<Product id: xxxxxx > 
> lb.available? 
=> true 
``` 
It won't automatically set 'available()' to true when you update a record. 

What if we need to bypass default scope? ActiveRecord also makes that easy, wrap code in call to the 'unscoped()' method.
``` 
Product.unscoped { Product.find_by_id(x) } 
``` 

Implicit scoping is convenient, hoever obfuscated. Without reading through models, another person might now know that a default scope is implied. 