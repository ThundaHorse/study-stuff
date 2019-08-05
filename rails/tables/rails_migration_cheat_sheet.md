------------------------------
#   Rails Migration Cheats  
------------------------------
Run 
```bash 
rails db:create 
```
Only need to do this once per app 

---------------------------------------------
#   To create a new table in the database: 
---------------------------------------------

1. run 
```bash 
rails generate model Product name:string desc:text 'price:decimal'
``` 
* model name needs to be upper camel case 

2. Double check generated migration file 
  • If there are typos we have to fix them now before proceeding 
```bash 
/in_the_db/migrate 
``` 
  2a. run 'rails db:migrate' 
    -> Reference: rails_column_types.md 

---------------------------------------------
#  Making changes to existing DB tables: 
---------------------------------------------

1. run 'rails generate migration XxxxXxxToXxxxx' 
2. Add code to new migration file generated in the db/migrate 
     folder 
    a. Add column: 'add_column :instance, :new_column, :data_type' 
    b. Rename: 'rename_column :instance, :old_name, :new_name'
    c. Remove: 'remove_column :instance, :column_to_remove, :d_type'
    d. Change dType: 'change_column :instance, :to_change, :d_type'
    e. Decimals(add): 'add_column :instance, :column, :decimal, precision: 5, scale: 2' 
      -> Precision: total # of digits 
      -> Scale: # of digits after the decimal 

      postgres has issues changing strings to decimals, 2 lines in migration to address: 
        • 'change_column: :instance, :column, "numeric USING CASE(price AS numeric)"' 
        • 'change_column :instance, :column, :decimal, precision: X, scale: X' 
** Active Record migrations: 
https://api.rubyonrails.org/classes/ActiveRecord/Migration.html

# 3. Check migration file code to fix typos before proceeding 

4. run 'rails db:migrate' 

Shortcuts for steps 1 and 2: 
• To add column to table: 
```bash 
rails generate migration XxxXxxToXxxXxx xxx:string 
``` 
• To remove a column: 
```bash 
rails generate migration XxxxXxxFromXxxx xxx:string 
``` 
* No other shortcuts are available, to rename or anything else we'll need to generate an empty migration file and write code in it as described. 

---------------------------------------------
#   Generate sample data for database 
---------------------------------------------
1. Write code in 'db/seeds.rb' file (instead of railse console) 
2. run 'rails db:seed' 
3. If we already have sample data created from rails console or 
   app, use this gem to generate a seed file so others can reproduce it. 
* https://github.com/rroblak/seed_dump
