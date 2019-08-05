-------------------------
#          Setup
-------------------------

Rails plugsin are built as gems, gemified plugins. Can be shared across different Rails applications using RubyGems and Bundler if desired. 

  • Generating a gemified plugin 
    Rails comes with a 'rails plugin new' command, creates a skeleton for developing any kind of Rils extension with the ability to run integration 
    tests using a dummy Rails application. 
```bash 
$ rails plugin new yaffle 

# See usage and options by asking for help: 

$ rails plugin new --help 
``` 

-------------------------
#   Testing Plugin 
-------------------------

You can navigate to the directory that contains the plugin, run the 'budle install' command and run the one generated test using the 'bin/test' command. 

What should show up is: 

```bash 
1 runs, 1 assertions, 0 failures, 0 errors, 0 skips 
``` 

This tells you that everything got generated properly and you're ready to start adding functionality 

-------------------------
#Extending Core Classes 
-------------------------

How to add a method to String that will be available anywhere in the Rails app 

```ruby 
# test/test/core_ext_test.rb 

require 'test_helper' 

class CoreExtTest < ActiveSupport::TestCase 
  def test_to_squawk
    assert_equal "swuawk! Hello World", "Hello World".to_swuawk 
  end 
end 
``` 

Run 'bin.test' to run the test. The test should fail because we haven't implemented the 'to_swuawk' method: 

```bash
E 
Error: 
CoreExtTest#test_to_swuak: 
NoMethodError: undefined method 'to_swuak' for 'Hello World':String 

bin/test /path/to/blah/core_ext_test.rb:4 

. 

Finished in X s, X runs/x, X assertions/s
X runs, X assertions, X failures, X errors, X skips 
``` 

-------------------------
#Testing Generated Plugin
-------------------------

Navigate to the directory that contains the plugin, run 'bundle install' and run one genereted test using 'bin/test' 

```bash 
X runs, X assertions, X failures, X errors, X skips 
``` 

This will tell you everything that got generated properly and you're ready to start adding functionality 

-------------------------
#Extending Core Classes 
-------------------------

Adding a method to String named 'to_swuak'. To start create a new test file with a few assertions: 

```ruby 
# test/test/core_ext_test.rb 

require "test_helper"

class CoreExtText < ActiveSupport::TestCase 
  def test_to_swuak 
    assert_equal 'squawk~ hello world', 'hello world'.to_squawk
  end 
end 
``` 

Rub 'bin/test' --> test should fail because no 'to_squawk' method 

In 'test/test/core_ext_test.rb', add 'require 'test/core_ext': 

```ruby 
# test/lib/test.rb 

require 'test/railtie' 
require 'test/core_ext' 

module Test 
  # code 
end 
``` 

Then create the 'core_ext.rb' file and add the 'to_squawk' method: 

```ruby 
# test/lib/test/core_ext.rb

class String 
  def to_sqauwk 
    'sqauwk! #{self}'.strip 
  end 
end 
``` 

run 'bin/test' from plugin directory 

```bash 
X runs, X assertions, X failures, X errors, X skips 
``` 

To see it in actino, change to the 'test/dummy' directory, open console and start squawking: 

```ruby 
$ bin/rails console 
>> "Hello World".to_squawk 
=> "squawk! Hello World" 
``` 

--------------------------------------------------
#   Add an 'acts_as' Method to Active Record 
--------------------------------------------------

A common pattern in plugins is to add a method called 'acts_as_something' to modules. 

```ruby 
# test/test/acts_as_test_test.rb 

require 'test_helper' 

class ActsAsTestTest < ActiveSupport::TestCase 
end 
``` 
```ruby 
# test/lib/test.rb

require 'test/railtie'
require 'test/core_ext'
require 'test/acts_as_test' 

module Test 
  # code 
end 
``` 
```ruby 
# test/lib/test/acts_as_test.rb

module Test 
  module ActsAsTest 
  end 
end 
``` 

This plugin will expect that you've added a method to your model named 'last_squawk'. However, the plugin users might have already defined a method on their model named 'last_squawk' that they use for something else. This plugin will allow the name to be changed by a class method called 'test_text_field' 

```ruby 
# test/test/acts_as_test_test.rb 

require 'test_helper' 

class ActsAsTestTest < ActiveSupport::TestCase 
  def test_a_blah
    assert_equal 'last_squawk', Blah.test_text_field
  end 

  def test_a_bleh_blah
    assert_equal 'last_tweet', Bleh.test_text_field 
  end 
end 
``` 

When you run 'bin/test' 

```bash 
# Running: 
..E 

Error: 
ActsAsTestTest#test_a_blah_text_field
NameError: unintialized constant ActsAsTestTest::Blah 

bin/test /path/test.rb 

E 

Error: 
ActsAsBlehTest#test_a_bleh_blah 
NameError: uninitialized contant ActsAsBlahTest::Bleh 

Finished... 
``` 

^ Tells us we don't have the necessary modules that we're trying to test. We can generate those modules by running these commands from the 'test/dummy' directory: 

```bash 
$ cd test/test 
$ bin/rails generate model Blah last_squawk:string 
$ bin/rails generate model Blah last_squawk:string 
last_tweet:string 
``` 

Now we can create the necessary database tables in the test database by going to test app and running migrate database 

```bash 
$ cd test/test 
$ bin/rails db:migrate 
``` 

While we're here, we can change the Blah and Bleh modules so they know what they're supposed to act like 

```ruby 
# test/test/app/modules/blah.rb 

class Blah < applicationRecord 
  acts_as_test 
end 

# test/test/app/modules/bleh.rb 

class Bleh < ApplicationRecord 
  acts_as_test test_text_field: :last_tweet 
end 
``` 

Also add code to define the 'acts_as_test' method 

```ruby 
module Yaffle 
  module ActsAsTest
    extend ActiveSupport::Concern 

    class_methods do 
      def acts_as_test(options = {}) 
      end 
    end 
  end 
end 

# test/test/app/models/application_record.rb 

class Bleh < ApplicationRecord 
  include Yaffle:ActsAsYaffle 

  self.abstract_class = true 
end 
``` 

Then return to the root directory of plugin and rerun the test 'bin/test'

```bash 
# Running:
 
.E
 
Error:
ActsAsTest#test_text_field:
NoMethodError: undefined method `test_text_field' for #<Class:0x0055974ebbe9d8>
 
 
bin/test /path/acts_as_test.rb:4
 
E
 
Error:
ActsAsTest#test_text_field:
NoMethodError: undefined method `test_text_field' for #<Class:0x0055974eb8cfc8>
 
 
bin/test /path/acts_as_test_test.rb:8
 
.
 
Finished in 0.008263s, 484.0999 runs/s, 242.0500 assertions/s.
 
4 runs, 2 assertions, 0 failures, 2 errors, 0 skips
``` 

Now implement the code of 'acts_as_test' method to make the test pass 

```ruby 

# yaffle/lib/yaffle/acts_as_yaffle.rb
 
module Yaffle
  module ActsAsYaffle
    extend ActiveSupport::Concern
 
    class_methods do
      def acts_as_yaffle(options = {})
        cattr_accessor :yaffle_text_field, default: (options[:yaffle_text_field] || :last_squawk).to_s
      end
    end
  end
end
 
# test/dummy/app/models/application_record.rb
 
class ApplicationRecord < ActiveRecord::Base
  include Yaffle::ActsAsYaffle
 
  self.abstract_class = true
end
``` 
Re-run 'bin/test' and all pass 

```bash 
4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

---------------------------------------
#       Add an Instance Method 
---------------------------------------

This plugin will add a method named 'squawk' to any Active Record object that calls 'acts_as_test'. The 'squawk' method will simply set the value of one of the fields in the database. 

To start, write a failing test to show the behavior you'd like. 

```ruby 

# yaffle/test/acts_as_yaffle_test.rb
require "test_helper"
 
class ActsAsYaffleTest < ActiveSupport::TestCase
  def test_a_hickwalls_yaffle_text_field_should_be_last_squawk
    assert_equal "last_squawk", Hickwall.yaffle_text_field
  end
 
  def test_a_wickwalls_yaffle_text_field_should_be_last_tweet
    assert_equal "last_tweet", Wickwall.yaffle_text_field
  end
 
  def test_hickwalls_squawk_should_populate_last_squawk
    hickwall = Hickwall.new
    hickwall.squawk("Hello World")
    assert_equal "squawk! Hello World", hickwall.last_squawk
  end
 
  def test_wickwalls_squawk_should_populate_last_tweet
    wickwall = Wickwall.new
    wickwall.squawk("Hello World")
    assert_equal "squawk! Hello World", wickwall.last_tweet
  end
end
``` 

Run the test to make sure the last two tests fail with an error that contains 'NoMethodError: undefined method 'squawk'". 
'then update' acts_as_test.rb to look like this: 

```ruby 

# yaffle/lib/yaffle/acts_as_yaffle.rb
 
module Yaffle
  module ActsAsYaffle
    extend ActiveSupport::Concern
 
    included do
      def squawk(string)
        write_attribute(self.class.yaffle_text_field, string.to_squawk)
      end
    end
 
    class_methods do
      def acts_as_yaffle(options = {})
        cattr_accessor :yaffle_text_field, default: (options[:yaffle_text_field] || :last_squawk).to_s
      end
    end
  end
end
 
# test/dummy/app/models/application_record.rb
 
class ApplicationRecord < ActiveRecord::Base
  include Yaffle::ActsAsYaffle
 
  self.abstract_class = true
end
``` 

Run 'bin/test' 

```bash 
6 runs, 6 assertions, 0 failures, 0 errors, 0 skips
``` 

The use of 'write_attribute' to write to the field in model is one example of how a plugin can interact with the model, won't always be the right method to use

You could use 
```bash
send("#{self.class.yaffle_text_field}=", string.to_squawk)
``` 

---------------------------------------
#             Generators 
---------------------------------------
Generators can be included in gem simply by creating them in a 'lib/generators' directory of the plugin. 

---------------------------------------
#       Publishing the Gem 
---------------------------------------
Gem plugins currently in development can easily be shared from any Git reposity, to share, commit the code to Git and add a line to the 'Gemfile' of the application in question: 

```ruby
gem 'yaffle', git: 'https://github.com/rails/yaffle.git' 
``` 

After running 'bundle install', your gem functionality should be available to whoever. 

When it's ready to be shared as a formal release, it can be published to RubyGems. 

---------------------------------------
#         RDoc Documentation 
---------------------------------------
Once the plugin is stable and it's ready for deployment, document it. 

First step is to update the README with detailed infor about how to use your plugin. Some things to include: 
  • Your name 
  • How to install 
  • How to add functionality to the app (common use cases) 
  • Warnings, gotchas, or tips that might be helpful 

Once the README is solid, go through the rdoc comments to all of the methods that developers will use.

It's customary to add '#nodoc:' comments to those parts of the code that are not included in the public API. 

Once it's good, go to the plugin directory and run: 

```bash 
$ bundle exec rake rdoc 
``` 
