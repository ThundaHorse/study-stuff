-----------------------------
# Problem: Relationship between 2 models is just a relationship. Relationships usually have their own data and their own meaning within a domain. 

-----------------------------

# Solution: 

-----------------------------
Rails uses join models to leverage Active Record's 'has_many :through' macro. 

When modeling many-to-many relationships, a majority of the time we use 'join' models. Join models are more of a technique or design pattern. 
  -> if your many-to-many relationship needs to have some richness in association, you can put a full table with an associated Active Record model. 

Sample schema: 
```ruby 
# rr2/many_to_many/beginning_schema.rb 
create_table :magazines do |t| 
  t.string :title 
  t.datetime :created_at 
  t.datetime :updated_at 
end 

create_table :readers do |t| 
  t.string :name 
  t.datetime :created_at 
  t.datetime :updated_at
end 

create_table :magazines_readers, :id => false do |t| 
  t.integer :magazine_id 
  t.integer :reader_id 
end 
``` 

The table joining the two sides is named after the tables it joins, with those two names in alphabetical order and separated by an underscore: 
  -> You would then say that the 'Magazine' model 'has_and_belongs_to_many :readers' and vice versa. 

This relationship enables you to write code such as 

```ruby 
magazine = Magazine.create(:title => "blah blah blah") 
abe = Reader.find_by_name("Abe") 
magazine.readers << abe 
abe.magazines.size # => 1 
``` 

It's possible with Rails to add attributes to a 'habtm' and store them in the join table along with a foreign key for associated X and X entities. 

However this technique relegates a real, concrete, first-class concept in our domain. We'd be taking what should be its own class and making it hang together as a set of attributes hanging from an association. 

This is where join models comes in, using join model we can maintain the directly accessible association between X and X while representing the relationship itself as a first-class object 

Magazine, reader, subscription example 
```ruby 
# rr2/many_to_many/db/migrate/XXXXXXXXXX_convert_to_join_model.rb 
def self.up 
  drop_table :magazine_readers 
  create_table :subscriptions do |t| 
    t.column :reader_id, :integer 
    t.column :magazine_id, :integer 
    t.column :last_renewal_on, :date 
    t.column :length_in_issues, :integer 
  end 
end 
``` 
New schema uses existing mags and reader tables but replaces magazines_readers join table with new table called 'subscriptions'. 
  -> Now we need to generate a Subscription model and modify all 3 models to set up associations 

```ruby 
# many_to_many_app_models_subscription.rb 
class Subscription < ActiveRecord::Base 
  belongs_to :reader 
  belongs_to :magazine 
end 

# many_to_many/app/models/reader.rb 
class Reader < ActiveRecord::Base 
  has_many :subscriptions 
  has_many :magazines, :through => :subscriptions 
end 

# many_to_many/app/models/magazine.rb 
class Magazine < ActiveRecord::Base
  has_many :subscriptions
  has_many :readers, :through => :subscriptions
end 
``` 

Subscription has many-to-one relationship with both 'Magazine' and 'Reader', making the 'implicit' relationship between 'Mag' and 'Reader' a many-to-many relationship. 

Now we can specify that a Magazine object has_many() readers through their associated subscriptions. 
  -> Both conceptual association and a technical one. 

In Rails C 
```ruby 
magazine = Magazine.create(:title => "blah") 
reader = Reader.create(:name => "Abe") 
subscription = Subscription.create(:last_renewal_on => Date.today), :length_in_issues => 6) 
magazine.subscriptions << subscription 
subscription.save 
``` 

This doesn't have anything new yet but now that we have association set up, we can do: 

```bash 
magazine.reload 
reader.reload
magazine.readers 
# [#<Reader id: 1, name: "Abe", ... >] 
reader.magazines 
# [#<Magazine id: 1, title: "blah",...>]
``` 

Although we never explicitly associated the reader to magazine, association is implicit through the ':through' parameter of the 'has_many()' declarations. 

# What happens behind the scenes? 
Rails generates a SQL select that joins the tables for us. when we did readers.magazine, this is generated. 

```SQL 
SELECT "magazines".* FROM "magazines"
  INNER JOIN "subscriptions" ON "magazines".id = "subscriptions".magazine_id 
  WHERE (("subscriptions".reader_id = 1))
``` 

With a join model relationship, still have access to all the same 'has_many' options we'd normally use. 

Sometimes name of a relationship isn't obvious to us. Step of trying to name relationships helps flesh out domain models in a positive way. 