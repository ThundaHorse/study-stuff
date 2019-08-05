------------------------------------------------------------
#Class 
#ActiveRecord::ConnectionAdapters::TableDefinition < Object 
------------------------------------------------------------

Represents a schema of a SQL table in an abstract way. Provides methods for manipulating the schema representation. 

The 't' object in create_table is of this type, inside migration files 

---------------------
# Attributes include: 
---------------------

[R] --> as, comment, foreign_keys, name, options, temporary 
[RW] --> indexes 

--------------------------
#Instance Public Methods: 
--------------------------

• [](name) --> returns a column definition with name 'name'

```ruby 
# File activerecord/lib/active_record/connection_adapters/abstract/schema_definitions.rb, line 284
def [](name)
  @columns_hash[name.to_s]
end
``` 

• belongs_to(*args, **optons) AKA references(*args, **options) 
  adds a reference, column is giint by default, the ':type' option can be used to specify a different type. 
  => optionally adds a _type column, if ':polymorphic' option is provided.
  =>  The 'options' hash can include the following keys:
':type' =>  reference column type. Defaults to ':bigint'. 
':foreign_key' =>  adds appropriate foreign key constraint, defaults to false. 
':index' =>  adds an appropriate index. 
':polymorphic' =>  whether an additioanl '_type' column should be added. Defaults to false 
':null' =>  whether the column allows nulls, defaults to true

--------------------
# remove_column(name)
--------------------
removes a column 'name' from the table 

