---------------------
#   Migrations 
---------------------
Migrations can manage evolution of schema used by several physical databses. It's a solution to problem of adding a field to make a new feature work in local database. 

With migrations, we can describe transformations in self-contained classes that can be checked into version control systems and executed against another database

E.G: 
```ruby 
class AddSsl < ActiveRecord::Migration[5.0] 
  def up 
    add_column :accounts, :ssl_enabled, :boolean, default: true 
  end 
``` 
Migration will add a boolean flag to accounts table. 

```ruby
  def down 
    remove_column :accounts, :ssl_enabled
  end 
end 
``` 
Will remove it if you're backing out of the migration. Describes transformations required to implement or remove the migration. 

The methods can consist of both the migration specific methods or regular Ruby code for generating data needed for the transformations. 

For more: 
https://api.rubyonrails.org/classes/ActiveRecord/Migration.html

https://guides.rubyonrails.org/v3.2/migrations.html#using-models-in-your-migrations