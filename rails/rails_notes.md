--------------------
Rails workflow 
--------------------
To create a new rails project: 
  rails new *name of app* 
* After creating, cd into the directory 

Create a postgres database: 
  rake db:create 

To generate a new controller: (name of controller must be PLURAL) 
  rails generate controller api/*name of controller* 

To create a new model: (name of model must be SINGULAR) 
  rails generate model *ameOfModel attribute1:string/integer ... 
* This command is run in terminal, no ',' or '' 

After creating each model, enter 
  rake db:migrate 

  When we run *rails server*, starts Rails development server so that we can preview the app. AKA WEBrick 


  -------------------------
  request/response cycle 
  -------------------------
    - What happens when we visit *http://localhost:XXXXX* 
      -> SAM https://code.tutsplus.com/tutorials/http-the-protocol-every-web-developer-must-know-part-1--net-31177
      -> request hits the Rails router in 
        config/routes.rb 
      -> The router recognizes the URL and sends the request to the controller 
    - The controller receives the request and processes it 
      -> controller determines how to combine/manipulate data and how app should respond 
    - Controller passes the request to the view 
      -> The view renders the page as HTML 
    - The controller sends the HTML back to the browser for you to see 

  ---------------------------------------------------------------------------

  We need 3 parts to build a Rails app,
    1. A controller -> rails generate controller 
      a. rails generate controller api/*name of controller* 
        • Generated a new controller by whatver name 
    2. A route 
    3. A view 
      a. After having a controller and route, we can open 
        app/views/layouts/*name*.html.erb

        SAMPLE 
```html
          <div class="main">
            <div class="container">
              <h1>Hello my name is Abe</h1>
              <p>I make Rails apps.</p>
            </div>
          </div>
```

      b. CSS is stored in app/assets/stylesheets/*name*.css

CRUD Methods 
------------------------------------


* C(reate) 
```ruby
  item = *ModelName.new({attr1: 'blah' ... etc})
  item.save 
```
------------------------------------------------------------------------

* R(ead) 
• Active Record provides five different ways of retrieving a single object.

  items = *ModelName.all
  item = *ModelName.first 
    - item = *ModuleName.first! 
      --> find the first record 
      => #<id: 1, attr...>
    - SQL -> SELECT * FROM clients LIMIT 1 
    • If nothing found --> raises RecordNotFound 
  item = *ModelName.last 
    - .last! --> last record 
    - SQL -> SELECT * FROM clients ORDER BY clients.id DESC LIMIT 1 
  item = *ModelName.find_by(attr: 'val') 
    - item = *ModuleName.find(id) <- only ID 
    - SQL equivalent = SELECT * FROM clients WHERE (clients.id = x) LIMIT 1

  ** Retrieving Multiple Objects 
    Using multiple primary keys 
      Model.find(array_of_primary_keys) 
        item = Model.find([1,10]) OR Model.find(1,10) 
          => <#id: 1, attr...>, <id: 10, attr...> 
      - SQL -> SELECT * FROM clients WHERE (clients.id IN (1,10)) 
      • Unless matching record is found for all supplied keys, raises  
        ActiveRecord::RecordNotFound 

  ** Retrieving multiple objects in batches 
    Model.all.each do |k| 
      block 
    end 

    Impractical as table size increases because Model.all instructs Active Record to fetch entire table in single pass, build a model object per row, and keep an entire array of model objects in memory. 

  2 ways to address the problem into memory-friendly processing 
    • find_each --> retrieves batch of records and then yields each record to 
                    the block individually as a module 
    • find_in_batches --> retrieves a batch of records and then yields the 
                          entire batch to the block as an array of modules 
    ^ are intended for use in batch processing of a large number of records that 
      wouldn't fit in memory all at once, usually ~1000, usual method is fine 

    The find_each method accepts most of the options allowed by find except for 
    :order and :limit, reserved for find_each. 
      - :batch_size and :start are available as well 

    :batch_size --> allows you to specify # of records to be retrieved in each 
                    batch before being passed individually into the block 
        => User.find_each(:batch_size => 5000) do |k| 
              block 
            end 

    :start --> allows you to configure the first ID of the sequence whenever the 
               lowest ID is not the one you need. 
            * Useful for picking up where you left off if interrupted batch 
              process
        => User.find_each(:start => xxx, :batch_size => xxx) do |k| 
              block 
            end 
  ** Conditions
    'where' allows you to specify conditions to limit the records returned
    - String conditions ** MORE VULNURABLE TO SQL INJECTION EXPLOITS 
      Client.where('condition') 

    - Array conditions --> Active Record will go through first element in the 
      conditions value and any additional elements will replace the question marks in the first element 
        => Client.where("condition = ?", params[:orders]) 

      * Specify multiple conditions 
        => Client.where("condition = ? AND condition =?", params[:orders], false)
          * First question mark will be replaced with the value in 
            params[:orders] 
          * Second will be replaced with the SQL representation of false (
            depends on adapter) 
        • Preferred 
          Client.where('condition = ?', params[:orders]) 
    - Placeholder conditions --> you can specify keys/values hash in your arr 
      => Client.where("created_at >= :start_date AND created_at <= :end_date",
          {:start_date => params[:start_date], :end_date => params[:end_date]})
    - Range conditions --> when looking for a range inside of a table 
      => Client.where(:created_at => (
      params[:start_date].to_date)..(params[:end_date].to_date))

    - Subset conditions --> if you want to find records using the IN expression 
      => Client.where(:orders_count => [1,3,5]) 

    - Ordering --> to retrieve records from database in specific order. Can specify ASC or DESC or multiple fields 
      => Client.order("created_at") 
      => Client.order("orders_count ASC, created_at DESC")

Other Active Record Querying 
https://guides.rubyonrails.org/v3.2.13/active_record_querying.html 

------------------------------------------------------------------------

* U(pdate) 
```ruby 
  item = ModelName.find_by(attribute1: “some value”)
  item.attribute_2 = "new updated value"
  item.save

  or

  item = ModelName.find_by(attribute1: “some value”)
  item.update(attribute1: “some value”)
``` 
------------------------------------------------------------------------

* D(elete)
```ruby 
  item = ModelName.find_by(attribute1: “some value”)
  item.destroy
``` 

------------------------------------------------------------------------

  Active Model --> library containing various modules used in developing classes that some features present on Active Record 

  Callbacks --> ActiveModel::Callbacks gives Active Record style callbacks. This
   provides an ability to define callbacks which run at appropriate times. After defining callbacks, you can wrap them with before, after and around custom methods

  Conversion --> If a class defines persisted? and id methods, then you can  
    include the ActiveModel::Conversion module in that class, and call the Rails conversion methods on objects of that class.

  Dirty --> An object becomes dirty when it has gone through one or more changes 
    to its attributes and has not been saved. ActiveModel::Dirty gives the ability to check whether an object has been changed or not. It also has attribute based accessor methods.

Model Basics --> https://guides.rubyonrails.org/active_model_basics.html

------------------------------------------------------------------------
                              Validations 
------------------------------------------------------------------------
ActiveModel::Validations --> adds ability to validate objects like in Active record 

```ruby
class Person 
  include ActiveModel::Validations 

  attr_accessor :name, :email

  validates :name, presence :true 
  validates_format_of_ :email, with /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i

end 

person = Person.new 
person.name = "me" 
person.valid?             #false 
person.email = "me.@me.com" 
person.valid?             #true 
ActiveModel::StrictValidatinFailed 
``` 


------------------------------------------------------------------------
                                Naming 
------------------------------------------------------------------------

ActiveModel::Naming adds a number of class methods which make naming and routing easier to manage. The module defines the 'model_name' class method which will define a number of accessors using some ActiveSupport::Inflector methods. 

```ruby
class Person 
  extend ActiveModel::Naming 
end 

Person.model_name.name       # "Person" 
Person.model_name.singluar   # "person" 
Person.model_name.plural     # "people" 
Person.model_name.il8n_key   # :person 
``` 

------------------------------------------------------------------------
                                Model
------------------------------------------------------------------------

ActiveModel::Model adds ability for a class to work with Action Pack and Action View right out of the box. 

```ruby
class EmailContact 
  include ActiveModel::Model 

  attr_accessor :name, :email, :message 
  validates :name, :email, :message, presence: true 

  def deliver 
    if valid? 
      # deliver email 
    end 
  end 
end 
end 
``` 

When including ActiveModel::Model you get some features like: 
  • Model name introspection 
  • Conversations 
  • Translations and validations 

Also gives you ability to initialize an object with a hash of attributes, much like any Active Record object.
``` 
email_contact.name    # => "Me" 
```

Any class that includes ActiveModel::Model can be used with 'form_for', 'render' and any other Action View helper methods 

------------------------------------------------------------------------
                            Serialization
------------------------------------------------------------------------
ActiveModel::Serialization provides basic serializaiton for your object. You need to declare an attributes Hash which contains the attributes you want to serialze. Attributes must be strings, not symbols.

```ruby
class Person 
  includes ActiveModel::Serialization 

  attr_accessor :name 

  def attributes 
    {'name' => nil}
  end 
end 

person.serialziable_hash  # => {"name" => nil} 
person.name = "me" 
person.serializable_hash  # => {"name" => "me"}

```

ActiveModel::Serializers::JSON is provided for JSON serializing/deserializing. This module automaticlaly includes the previously discussed stuff. 

To use ActiveModel::Serializers::JSON you only need to change the module you are including from ActiveModel::Serialization to ActiveModel::Serializers::JSON 

```ruby 
class Person 
  include ActiveModel::Serializers::JSON

  attr_accessor :name 

  def attributes 
    {'name' => nil} 
  end 
end 

person = Person.new 
person.as_json    # => {'name' => nil} 
person.name = 'me' 
person.as_json    # => {'name' => 'me'} 
``` 

Now it is possible to create an instance of Person and set attributes using from_json 

``` ruby
json = {name: 'me'}.to_json
person = Person.new 
person.from_json(json)   # => #<Person:'whatever' @name='me'> 
person.name              # 'me' 
``` 

------------------------------------------------------------------------
                            Translation 
------------------------------------------------------------------------
ActiveModel::Translation provides integration between your object and the Rails internationalization framework 

```ruby 
class Person 
  extend ActiveModel::Translation 
end 
``` 

With the human_attribute_name method, you can transform attribute names into a more human-readable format. The human-readable format is defined in 
  • config/locales/app.pt-BR.yml 
```ruby
pt-BR:
  activemodel:
    attributes:
      person:
        name: 'Me'
``` 
```ruby 
Person.human_attribute_name('name')   # => "Me"
``` 

With the human_attribute_name method, you can tra


------------------------------------------------------------------------
                            Lint Tests 
------------------------------------------------------------------------
ActiveModel::Lint::Tests allows you to test whether an object is compliant with the Active Model API 
  • app/models/person.rb 
```ruby 
class Person 
  include ActiveModel::Model 
end 
``` 
  • test/models/person_test.rb
```ruby 
require 'test_helper' 

class PersonTest < ActiveSupport::TestCase 
  include ActiveModel::Lint::Tests 

  setup do 
    @model = Person.new 
  end 
end 
``` 

```ruby 
$rails test 
Run options: --seed 14596

# Running: 

.....

Finished in XXs, XX runs/s, XX assertions/s. 

X runs, X assertions, X failures, X errors, X skips 
``` 

------------------------------------------------------------------------
                        SecurePassword 
------------------------------------------------------------------------

ActiveModel::SecurePassword provides a way to securely store any password information in an encrypted form. When you include this module, a has_secure_password class is provided which defines a 'password' accessor with certain validaitons on it. 

REQUIREMENTS 

ActiveModel::SecurePassword depends on the bcrypt, so include the gem in 'Gemfile' to use ActiveModel::SecurePassword correctly. 

In order for it to work, the model must have an accessor named 'password_digiset'. The 'has_secure_password' will add the following validations to the 'password' accessor: 

1. Password should be present. 
2. Password should be equal to its confirmation (provided 'password_confirmation' is passed along). 
3. Max length of a password is 72 (required by 'bcrypt' on which ActiveModel::SecurePassword depends). 