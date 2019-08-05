--------------------------------------------
#   How to create a Ruby gem with Bundler 
--------------------------------------------
Bundler is a tool created by Carl Lerche, Yehuda Katz, Andre Arko and others. 

Why? What is we want to use the code elsewhere or want to share it? This is why a gem is perfect. 

We can code our library and gem separately from each other and just have the library require the gem. If we wanna use a gem from another library, just a tiny modification vs a fuck ton of copying. 

--------------------------------------------
#             Getting Started 
--------------------------------------------
To check which version of bundler, run 

```bash 
$ bundle -v
``` 

Output should be something close to 'Bundler version x.x.x' If necessary, you can update to the newest version of Bundler by running 'gem update bundler' 

To begin, run the command 'bundle gem' 

```bash 
$ bundle gem foodie 
``` 

This command creates a scaffold directory for our new grem, if Git installed, initializes a repo in this directory so that we can start commiting right away. 

What is generated? 

• Gemfile: Used to manage gem dependencies from our library's development. 
  -> Contains 'gemspec' line meaning that Bundler will 
     include dependencies specified in the 'foodie.gemspec' too. 
  -> Best practice to specify all the gems that our library 
     depends on in the 'gemspec' 

• Rakefile: Requires Bundler and adds the 'build', 
            'install' and 'release' Rake tasks by way of calling 'Bundler::GemHelper.install_tasks' 
  -> 'build': will build the current version of the gem and 
              store it under the 'pkg' folder. 
  -> 'install': will build and install the gem to our 
                system 
      (just like 'gem_install'). 
  -> 'release': will push the gem to Rubygems for 
                consumption by the public. 

• CODE_OF_CONDUCT.md: provides a code of conduct that you will expect all contributors of your gem to follow. Only included 
                      if you chose to have it included. 

• .gitignore: (Only if you have Git.) Ignores anything in the pkg directory (generally files put there by the 'rake build'), 
            anything with a '.gem' extension and the '.bundle' directory                     

• foodie.gemspec: The Gem specificaiotn file. This is where we provide info for Rubygems' consumption such as name, 
                 description, and homepage of our gem. Also where we specify the dependencies our gem needs to run.  

• lib/foodie.rb: The main file to define our gem's code. This is the file that will be required by Bundler (or any similarly 
                smart system) when our gem is loaded. The file defines a 'module' which we can use as a namespace ofr all our gem's code.

• lib/food: ^ best practice to put code in this file. This is the file contains all the code for our gem. The 'lib/foodie.rb' 
            file is there for setting up gem's environment, whilst all the parts of it go in this folder. If gem has multiple uses, separating this out so that people can require one class/file at a time can be helpful. 

• lib/foodie/verson.rb: Defines a 'Foodie' module and in it, a 'VERSION' constant. This file is loaded by the foodie.gemspec 
                        to specify a version for the gem specification. When we release a new version of the gem we will incremenet a part of this versin number to indicate to Rubygems that we're releasing a new version

--------------------------------------------
#            Testing our gem 
--------------------------------------------
For this part, we use RSpec to test our gem. We write tests to ensure that everything goes according to plan and to prevent future-us from building a time machine to come back and kick us in the ass. 

To get started, we create 'spec' directory at the root of the gem by using 'mkdir spec'. Next specify in our 'foodie.gemspec' file that 'rspec' is a development dependency by adding this line in the 'Gem::Specification' block: 

```ruby 
spec.add_development_dependency "rpsec", "~> 3.2" 
``` 
 Because we have the 'gemspec' method call in our Gemfile, Bundler will automatically add this gem to a group called "development" which then we can reference any time we want to load these gems with the folowing line: 

```ruby 
Bundler.require(:defualt, :development) 
``` 

The benefit of putting this dependency specificaiton inside of 'foodie.gemspec' rather than the Gemfile is that anybody who runs 'gem install foodie --dev' will get these development dependencies installed too. Command is used for when people wish to test a gem without having to fork it or clone it from GitHub. 

When 'bundle install' is run, rspec will be installed for this library and any other library we use with Bundler, but not for the system. 

** IMPORTANT ** 
any gem installed by Bundler wont fuck around with gems installed by 'gem install' 

By running 'bundle install', Bundler will generate the extremely important 'Gemfile.lock' file. 
  -> Responsible for ensuring that every system this library is developed on has the exact same gems so it shuold always be   
     checked into version control. 

Additiaonlly, the 'bundle install' output will look like this 

```bash
Using foodie (0.1.0) from source at /path/to/foodie 
``` 

Bundler detects our gem, loads the gemspec and bundles our gem just like every other gem. 

We can write our test with this framework now in place. For testing, first we create a folder called spec to put our tests in ('mkdir spec'). Then we create a new RSpec file for every class we want to test at the root of the 'spec' directory. 

If there were multiple facets to the gem, group them underneath a directory such as 'spec/facet'. 

Call the new file 'spec/foodie_spec.rb' and fill with following... 

```ruby 
describe Foodie::Food do 
  it 'broccoli is gross' do 
    expect(Foodie::Food.portray('Broccoli')).to eql("Gross!")
  end 

  it 'anything else is delicious' do 
    expect(Foodie::Food.portray("Not Broccoli")).to eql("Delicious!")
  end 
end 
``` 

When we run 'bundle exec rspec spec' again, we'll be told 'Foodie::Food' constant doesn't exist. It's true, define it in 
'lib/foodie/food.rb' like so 

```ruby
module Foodie 
  class Food 
    def self.portray(food) 
      if food.downcase == 'broccoli'
        'Gross!'
      else 
        'Delicious!'
      end 
    end 
  end 
end 
``` 

To load the file, we'll need to add a require line to 'lib/foodie.rb' for it: 
```ruby
require 'foodie/food' 
``` 
We also need to require the 'lib/foodie.rb' at the top of 'spec/foodie_spec.rb' 

```ruby 
require 'foodie' 
``` 

After running specs with 'bundle exec rspec spec' 

```bash 
2 example, 0 failures 
``` 

--------------------------------------------
#           Using other gems 
--------------------------------------------
No we use Active Support's 'pluralize' method by calling it using a method from the gem. 

To use another gem, must first specify it as a dependency in our 'foodie.gemspec'. We can specify the dependency on the 'activesupport' gem in 'foodie.gemspec' by adding this line inside the 'Gen::Specification' object: 

```ruby 
spec.add_dependency 'activesupport' 

# If we wanted to specify a particular version, can include: 

spec.add_dependency 'activesupport', '4.2.0' 

# Or specify a version constraint 

spec.add_dependency 'activesupport', '>= 4.2.0' 

# Relying on a version greater than the latest-at-the-time is a sure-fire way to run into problems later on. Try to use '~>' for specifying dependencies 

spec.add_dependency 'activesupport', '~> 4.2.0' 
``` 

When we run 'bundle install' again, the 'activesupport' gem will be installed for use. Test the 'pluralize' method before it's coded. 

```ruby 
it 'pluralizes a word' do 
  expect(Foodie::Food.pluralize("Tomato")).to eql("Tomatoes")
end 
``` 

When the above is run with 'bundle exec rspec spec' it will fail: 

```bash 
expect(Failure/Error: Foodie::Food.pluralize("Tomato")).to eql("Tomatoes")
     undefined method `pluralize' for Foodie::Food:Class
``` 

No we can define the 'pluralize' method in 'lib/foodie/food.rb' by first requiring the part of Active Support which contains the 'pluralize' method. Line should go at the top of the file just like 'require' does. 
```ruby 
require 'active_support/inflector' 
``` 

Next define 'pluralize' method 

```ruby 
def self.pluralize(word) 
  word.pluralize
end 
``` 

When 'bundle exec rpsec spec' is run, it will pass 

```bash 
3 examples, 0 failures 
``` 

