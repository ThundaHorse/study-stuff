------------------

# Problem: 

------------------
When we access a 'has_many' or habtm on an Active Record model, returns an array-like obj that provides access to individual objs that're associated with the obj. 

Sometimes, might wanna add behavior to association. Adding can make it expressive and easier to understand 

------------------

# Solution: 

------------------
A Proxy -> a collection returned by an Active Record association 

Collection proxies -> wrappers around the colelctions, allowing them to be lazily loaded and extended. 
  -> To add behavior to an Active Record association, we can add it to the collection proxy during the call to 'has_many()'


Model demonstrates students and their grades in school: 
```ruby 
# rr2/assoc_proxies/db/migrate/XXXXXX_create_students.rb 
class CreateStudents < ActiveRecord::Migration 
  def self.up 
    create_table :students do |t| 
      t.string :name 
      t.integer :graduating_year 
      t.timestamps 
    end 
  end 

  def self.down 
    drop_table :students 
  end 
end 

# rr2/assoc_proxies/db/migrate/XXXXXX_create_grades.rb 
class CreateGrades < ActiveRecord::Migration
  def self.up 
    create_table :grades do |t| 
      t.belongs_to :student 
      t.integer :score 
      t.string :class_name 

      t.timestamps
    end
  end

  def self.down 
    drop_table :grades 
  end 
end 
``` 

Then create Active Record models for these tables. Declare 'Student' class 'has_many()' grades. 

```ruby 
# AddingBehaviorToActiveRecordAssociation/app/models/student.rb 
class Student < ActiveRecord::Base 
  has_many: grades 
end 

# AddingBehaviorToActiveRecordAssociations/app/models/grade.rb 
class Grade < ActiveRecord::Base
end 
``` 

Now that we have a working model, create some objects and notice that this has gotten weird, wher does 'create()' come from? 

```bash 
$ rails console 
>> me = Student.create(:name => "abe", :graduating_year => 2020) 
=> #<Student:xxxx @new_record=false, @attributes={"name"=>"abe", "id"=>1, "graduating_year"=>2020}> 
>>me.grades.create(:score => 1, :class_name => "ruby") 
=> #<Grade:xxxx @new_record=false, @errors={}>, @attributes={"score"=>1, "class_name"=>"ruby", "student_id"=>1, "id"=>1}> 
```

What's happening is that the call to 'grades()' returns an instance of 'ActiveRecord::Associations::CollectionProxy' 
  -> This is between model's client code and actualy objs in 
     model associated with. 
  -> Acts as an object of the class you expect and delegates that 
     calls to the appropriate app-specific model objs 

UNDASTAND that association call really returns a proxy. 
  -> You would just need to create a new instance of 
     'CollectionProxy' 
    -> BUT we can't just get the association via a call to 
       something to add our behaviors to it 

Active Record controls creation and return of objs, we need to ask Active record to extend proxy obj for us 

Active Record gives 2 ways to accomplish ^ 
  1. Could define additional methods in module and then extend 
     association proxy with the module 
  2. Could define method directly by passing a block to 
     declaration of the desired association 

Inside scope of one of these extended methods holds a special variable 'self', refers to Array of associated Active Record objs, means you can index into array and perform other shit otherwise restricted to arrays. 

Understanding association proxies is one of the ekys to expressive Act Rec development. 