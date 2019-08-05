------------------------------------
# Problem: 
What if we need to connect multiple datbases? 

-----------------------------

# Solution: 
We set up connections in our apps database configuration, configure Active Record models, and use inheritance to safely allow multiple models to use new named connection. 

------------------------------------

To understand how to connect multiple dbs from Rails app, best place to start is to understand how default connections are made. 
  -> How does an app go from YAML config file to db connection? How does Active Record model know which db to use? 

When a Rails app boots, it invokes Rails initialization process. This process ensures that all components of Rails are properly set up and glued together. 

In Rails 3+, works by delegating each subframework of Rails and asking that subframework to initialize itself. 
  -> Each of these initializers is called a 'Railtie' 
  -> ActRec defines ActiveRecord::Railtie to play initialization role. 
    • One of its roles is to initialize database connections 

The ActRec 'Railtie' is responsible for calling method 'ActiveRecord::Base.establish_connection()' 
  -> If called with no arguments, it'll check value of Rails.env variable and look up that value in the loaded 'config/database.yml'
  -> Default value for 'Rails.env' is 'development'. 
  -> By default, it'll look up the db config section named 'development' in its 'config/database.yml' file and set up a connection to that db. 

An actual connection hasn't been establed yet. ActRec doesn't actually make the connection until it needs it, which happens on the first reference to the class's connection() method. 

------------------------------------

Having set up a connection to db solves only part of the puzzle. Connection still has to be referenced by model classes that need it. 

When default connection is made by the 'Railtie', they're made directly from ActRec::Base class
  ** which is the superclass of all Act Rec models. 

Because the call to 'establish_connection()' is made on 'ActRec::Base', connection is associated with that class and is made available to all its child classes (app specific models) 

In a default case, all models get access to this default connection. 
If you make a connection from one of your model classes (by calling establish_connection()), that connection is available from that class and any of its children but NOT from its superclasses, including ActRec::Base 

When asked for its connection, the behavior of a model is to start with the exact class the request is made from and work its way up the inheritance hierarchy until it finds a conenction. 
  -> Important in working with multiple databases. 
  -> A model's connection applies to that model and any of its children unless overridden 

------------------------------------
# Hypothetical example 
------------------------------------
• 2 databases, one is 'development' and be default 
• Other will be a hypothetical one for external product 
• Tables created in these databases so we can hook them up to Active 
  Record models  

In a typical scneario, secodn database would be the one that already exists, wouldn't want to control via Active Record migrations.

As a result, Active Record's migrations wasn't designed to manage multiple databses. 
  -> Its Okay, if you have that level of control over db and tables 
     are all related, better off putting them all together anyways 

• For this example, assume that products db already has a table called products, with a field for name and price. 

• Generate models for 'User', 'Cart', Product' 

User model can have an associated 'Cart' which can have multiple 'Products' in it. 

```ruby 
# rr2/multiple_dbs/app/models/user.rb 
class User < ActiveRecord::Base 
  has_one :cart 
end 
``` 
Things get tricky here with 'Cart'. It associates with 'User' in the usual way. We can't use 'has_many()' with a join model to link ':products' because 'products' table isn't the same database. 
  -> The 'has_many()' will result in a table join, which we can't do 
     across db connections. 

Active Record establishes connections in hierarchial fashion, when attempting to make db connection. 
Active Record models look for the connection associated with either themselves or the nearest superclass. 

In the case of 'Product' class, we've set the connection directly meaning that when we do db ops with 'Product' model, they will use the connection to our configured 'products' db. 

------------------------------------

If we call 'Product.find()', we would be performing our select against the 'products' db. So how to associate 'Cart' with 'Products'? 

Create a mapping table in app's default db (same one that 'cart' table exists it) 

```ruby 
# rr2/multiple_dbs/db/migrate/XXXXXX_create_product_references.rb 
class CreateProductReferences < ActiveRecord::Migration 
  def self.up 
    create_table :product_references do |t| 
      t.integer :product_id 
      t.timestamps 
    end 
  end 

  def self.down 
    drop_table :product_references 
  end 
end 
``` 

This table's sole purpose is to provide a local reference to a product. The product's 'id' will be stored in the product reference's 'product_id' field. 

THEN 

create a model for new table: 

```ruby 
# rr2/multiple_dbs/app/models/product_references.rb 
class ProductReference < ActiveRecord::Base
  belongs_to :product 
  has_many :selections 
  has_many :carts, :through => :selections 

  def name 
    product.name 
  end 
  def price 
    product.price 
  end 
end 
``` 

We've created the 'has_many()' relationship b/t new 'ProductReference' class and the 'Cart' class with a join model called 'Selection'. 
  -> We've associated each 'ProductReference' with a 'Product'. 

This is the 'Selection' definition: 

```ruby 
# rr2/multiple_dbs/app/models/selection.rb 
class Selection < ActiveRecord::Base 
  belongs_to :cart 
  belongs_to :product, :class_name => "ProductReference"
end 
``` 

Since 'Product' class is simple, also manually delegated calls to 'name()' and 'price()' to 'Product', so for read-only purposes, product 'reference' is functionally equivalent to 'Product' 

Now all that's left is to associate 'Cart' with its products: 
```ruby 
# rr2/multiple_dbs/app/models/cart.rb 
class Cart < ActiveRecord::Base
  hase_many :selections 
  has_many :products, 
           :through => :selections 
end 
``` 
We can now say things such as 'User.first.cart.products.first.name' and get data we desire. 
  -> This would require the necessary rows to be created in 'product_references' table to match any products we have in the alternate db. 
    • Can be done either in a batch or automatically at runtime. 

Solution to a problem by adding calls to 'establish_connectoin()' which results in separate connections for every model that we reference. 
 -> Define a parent class for all the tables that are housed on the 
    same server. Then inherit from parent class for those external models. 
```ruby 
# rr2/multiple_dbs/app/models/external.rb 
class External < ActiveRecord::Base
  self.abstract_class = true 
  establish_connection :products 
end 

# Then 'Product' and 'TaxConversion' models can inherit from 'External' 

#ConnectingToMultipleDatabases/app.models/product.rb 
class Product < External 
end

# rr2/multiple_dbs/app/models/tax_conversion.rb 
class TaxConversion < External 
end 
``` 
We moved 'establish_connection()' call from 'Product' to 'External'. 
  -> Results in all subclasses of 'External' using the same 
     connection.  
  -> Also set 'abstract_class' to 'true' to tell Active Record that 
     the 'External' class doesn't have an underlying db table. 

We won't be able to instantiate an 'External' since there's no matching db table. If there is a db table called 'externals' choose a different name for class 

# Takeaways: 
- House new tables in given app in the same db
  => No sense in making it harder than it needs to be 

- If you have to continue using an external db
  => Might wanna consider exposing that data as a REST service, 
     allowing access only via HTTP calls as direct db access. 

- For read-only feeds of data that need to participate in complex joins
  => Consider replicating the data from its source table to the db 
     that needs to use it 
