------------------------------------
#     Validations Overview 
------------------------------------
Validation lets us know that our class is not valid without a `xxxx` attribute.

Validations are used to ensure that only valid data is saved into our database. Model-level validations are the best way to ensure that only valid data is saved into our DB. 

They're database agnostic, can't be bypassed by end users, they're convenient to test and maintain. 
  -> Rails makes them easy to use, provides built-in helpers for common needs, 
     allows you to create your own validation methods as well. 

Several ways to validate data before it's saved into your DB, including native DB constraints, client-side and controller-level validations. 

------------------
# Pros vs Cons? 
------------------
```ruby
• DB constraints and/or stored procedures make validation mechs DB dependent. 
    -> testing and maintenance can be more difficult. 
    -> If used by a lot, could be good, validations safely handle things 
• Client-side validations can be useful, but generally unreliable if used 
  alone. 
• Controller-level validations often unravel and are difficult to test/ 
  maintain. 
    -> Usually good idea to keep contorllers skinny, it'll make app more 
       streamlined. 
```

------------------------------------
#  When does validation happen? 
------------------------------------
There are 2 kinds of Active Record objects: 
  1. Those that correspond to a row inside DB 
  2. Those that do not 

When we create a fresh object (i.e. using `new` method), that object doesn't belong to the DB yet. 
  -> Once we call `save` on that object, it will be saved into the DB table. 

Active Record uses the `new_record?` instance method to determine whether an object is already in the DB or not. 

Creating and saving a new record will send a SQL `INSERT` operation to the database. Updating an existing record will send a SQL `UPDATE` operation instead. 

Validations are typically run before these commands are sent to the database. If any fail, object will be marked as invalid and Active record will not perofrm the `INSERT` or `UPDATE` operation. 
  -> Avoids storing invalid object in the database. 

The following trigger validations, only save if valid: 
` 
• create and create! 
• save and save! 
• update and update! 
` 
! versions raise an exception if the record is invalid, non-bang versions `save` and `update` return `false`, and `create` just returns the object. 

------------------------------------------------
# Skipping Validations + valid? and invalid? 
------------------------------------------------
The following methods skip validations, will save object to DB regardless of its validity, be careful! 

```bash 
• decrement! & increment! 
• decrement_counter & increment_counter 
• toggle! 
• touch 
• update_all, update_attribute, update_column, update_counters 

`save` also has ability to skip validations if passed `validate:false` as an 
argument, careful~ 

• save(validate: false) 

```

Before saving an Active Record object, Rails runs validations, if validations produce any errors -> no save. 

`valid?` triggers validations and returns true if no errors were found in object, false otherwise. 

After AR performs validations, any errors found can be accessed through `errors.messages` instance method. 
  -> returns a collection of errors 
  -> Technically, object is valid if this collection is empty after running 
     validations
  -> Objects instantiated with `new` will not report errors even if it's 
     technically invalid, validations are auto run only when obj is saved

`invalid?` is the opposite of `valid?`, triggers validations -> true if any errors were found, false otherwise. 