--------------------------

# Problem: 

--------------------------

Sometimes you want to use one table and model to represent something that can be associated with many types of entities. 
The 'has_many()' relies on a foreign key, which should uniquely identify the owner of the relationship. 
  -> When mixing multiple owning tables, you can't rely on foreign key to be unique across multiple tables 

How do you associate models from one table to records from multiple ones? 

--------------------------

# Solution: 

--------------------------
This looks like a job for 'polymorphic associations'. It allows you to associate *one* type of object with objects of *many* types. 

Example: 
`Address` can belong to `Person` or `Company` or any other model that wants to declare and use the association. 

_drop table is for rollbacks, this is for older versions_** 

```ruby 
# rr2/polymorphic/db/migrate/20101214163755_create_people.rb
class CreatePeople < ActiveRecord::Migration def self.up
  create_table :people do |t| t.string :name t.timestamps
  end 
end

def self.down 
  drop_table :people
  end 
end

# rr2/polymorphic/db/migrate/20101214163759_create_companies.rb
class CreateCompanies < ActiveRecord::Migration 
  def self.up
    create_table :companies do |t| 
      t.string :name
      t.timestamps
    end 
  end
  
  def self.down 
    drop_table :companies
  end 
end

# rr2/polymorphic/db/migrate/20101214163839_create_addresses.rb
class CreateAddresses < ActiveRecord::Migration 
  def self.up
    create_table :addresses do |t| 
      t.string :street_address1 
      t.string :street_address2 
      t.string :city
      t.string :state
      t.string :country 
      t.string :postal_code 
      t.integer :addressable_id 
      t.string :addressable_type 
      t.timestamps 
    end 
  end 

  def self.down
    drop_table :addresses
  end 
end 
``` 
What's weird? 
- The name of foreign key is `addressable_id`. 
- We've added column called `addressable_type` 

-------------------
# Now that we have db schema 
Create some models using generator. We'll generate models for `Person`, `Company`, and `Address`. 
  -> Then add `has_many()` declarations to `Person` and `Company` models via: 

```ruby 
# rr2/polymorphic/app/models/person.rb 
class Person < ActiveRecord::Base 
  has_many :addresses, :as => :addressable 
end 

# rr2/polymorphic/app/models/company.rb 
class Company < ActiveRecord::Base 
  has_many :addresses, :as => :addressable
end 
``` 

The `has_many()` calls in the two models are _identical_. 

# Tf does that mean? 

The `:as` option part of the new polymorphic association implementaion tells Active Record that current model's role in this association is that of an 'addressable' as opposed to 'person' or a 'company'. 

*This is where polymorphic comes in*. 
 -> Although the models exist as representations of people or 
    companies, in context their association with an `Address` effectively assume the _form_ of an 'addressable' thing. 

Next: Modify generated `Address` model to say that it `belongs_to()` addressable things 

```ruby 
# rr2/polymorphic/app/models/address.rb 
class Address < ActiveRecord::Base 
  belongs_to :addressable, :polymorphic => true 
end 
``` 

*IF* we had omitted `:polymorphic` option in `belongs_to()`: 
 => Active Record would've assumed the `Addresses` belonged to 
    objects of class `Addressable` and would have managed the foreign keys and lookups in the usual way. 

*Becase we included* `:polymorphic` option in `belongs_to()`, Active Record knows to perform lookups based on both `foreign key` and the `type`. 
  • The same is true of the `has_many()` lookups and their 
    corresponding `:as` options. 

Here's the shit in *action* 

```bash 
person = Person.create(:name => "Abe") 
=> #<Person id: 1, name: "Abe", created_at: XXXXX > 
address = Address.create(attributes) 
=> #<Address id:1 XXXXXX > 
adderss.addressable = person 
=> #< Person id: 1, name "Abe", created at XXXXX> 
address.addressable_id 
=> 1 
address.addressable_type 
=> "Person" 
``` 
*WTF HAPPENED?!?!?* 
Associating a `Person` with an `Address` populates both the `addressable_id` field and the `addressable_type` field. 

*Notice* `addressable_id` values have been set to 1. If relationship wasn't declared to be polymorphic. 
=> A call to `Company.find(1).address` would result in the same(incorrect) list that `Person.find(1).addresses` would return  
  -> Why? 
    Because Active Record would have no way of distinguishing between person 1 and compoany 1 

# SQL: 
```sql 
SELECT * 
        FROM addresses 
        WHERE (addresses.addressable_id = 1 AND 
               addresses.addressable_type = 'Company') 
``` 

It's easy to configure polymorphoic associations but sometimes duplication isn't that bad. 

Why? 

A separate address table for people and companies might be the right design for the app. 

*IF* you do use polymorphic, be sure to carefully consider the right indexes for tables, since you'll be performing many queries using both associated `id` and `type` fields. 