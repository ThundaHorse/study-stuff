--------------------------------------------
#   Testing a command line interface 
--------------------------------------------
David Chelimsky and Aslak Hellesoy made Aruba, a CLI testing tool whic they both use for RSpec and Cuccumber. 

Define new development dependencies in 'foodie.gemspec' now for the Cuccumber thigs: 

```ruby 
spec.add_development_dependency "cuccumber" 
spec.add_development_dependency "aruba" 
``` 

Run 'bundle install' to get the tools set up 
CLI is going to hvae two methods, which correspond to the 2 we defiend in 'Foodie::Food'. Now we create a features directory where we will use Aruba to write tests for our CLI. In this directory, we create a new file called 'features/food.feature' and fill it with the below: 

```ruby  
Feature: Food
  In order to portray or pluralize food
  As a CLI
  I want to be as objective as possible

  Scenario: Broccoli is gross
    When I run `foodie portray broccoli`
    Then the output should contain "Gross!"

  Scenario: Tomato, or Tomato?
    When I run `foodie pluralize --word Tomato`
    Then the output should contain "Tomatoes"
``` 
These scenarios test the CLI our gem will provide. In the 'When I run' steps, 
1. The first word inside the quotes is the name of the executable. 
2. Second is the task name. 
3. Any further text is arguments or options. 

It's testing the same things as our specs, however it's testing through a CLI. 

The first scenario ensures that we can call a specific task and pass it a single argument which then becomes the part of the text that is output. 
The second scenario ensures effectively the same thing, but we pass that value in as an option rather than an argument. 

To run the feature, we use the 'cucumber' command, but because it's available within the context of our bundle, we use 'bundle exec cucumber'

```bash 
$ bundle exec cuccumber features/ 
``` 

The yellow undefines steps: 

```bash 
When /^I run "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the output should contain "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
``` 

We can define them by requiring Aruba. In Cucumber, all .rb files in the 'features/support' directory are automatically required. To prove it, add a 'features/support/setup.rb' file (create the 'support' directory first) and put 
```ruby
require 'aruba/cucumber' 
``` 

This loads the Cucumber steps provided by Aruba which are the same steps our Cucumber features need. 

We have to re-run 'bundle exec cucumber features' jsut to see what happens next. We see red, contains stuff that means it can't find the executable file for the gem. 

```bash 
sh: foodie: command not found 
``` 

We can create a 'exe' directory at the root of the gem, and then put a file in it named 'foodie'. File has no extension because it's an 'executable' file rather than a script. 

We don't want to go around calling 'foodie.rb' everywhere so we fill the file with this content: 

```ruby  
# !/users/bin/env ruby 
print "nothing" 
``` 

If the file was empty, we would run into a 'Errno::ENOEXEC' error, to make a file to be executable from terminal, 'chmod' 

```bash 
$ chmod +x exe/foodie 
``` 

Our 'exe/foodie' file is empty, which results in nothing. Replace 'print "nothing"' and replace it with all the code required to run CLI, which consists of 2 lines. 

```ruby 
require 'foodie/cli' 
Foodie::CLI.start 
``` 

When we run 'bundle exec cucumber features' it will say there's no 'foodie/cli' file to require. The 'start' method starts up the 'CLI' class and will look for a task that matches the one we ask for. 

Next step is to create this file, but what does it do?? 

The new 'lib/foodie/cli.rb' file will define the command line interface using another gem called 'Thor'. Thor was created as an alternative to the Rake build tool. 
Thor provides a handy API for defining the CLI, including usage banners and help output. Syntax is similar to Rake. Additionally, Rails and Bundler both use Thor for their CLI interface as well as generator. 

----------------------------
#     Crafting a CLI 
----------------------------
To make the CLI work, we need to create a 'Foodie::CLI' class and define a 'start' method on it. 

Using Thor to build a CLI and generator 

Define the 'lib/foodie/cli.rb' file looks like: 
```ruby 
require 'thor' 
module Foodie 
  class CLI < Thor 

  end 
end 
``` 

The 'Thor' class has multiple methods, such as 'start' method referenced in 'exe/foodie' that we can use to create the CLI. 

In order for this to work, we have to tell the 'gemspec' that we depend on this gem by adding the line underneath the previous 'add_dependency' 

```ruby 
spec.add_dependency "thor" 
``` 

To install the new dependency, use 'bundle install'. While running the 'bundle exec cucumber features' again, we'll see that it's now complaining that it could not find the tasks called: 

```bash 
Could not find the task 'portray' 
...
Could not find the task 'pluralize'
``` 

Thor tasks are defined as methods, but with a slight difference, to define the 'portray' task in 'Foodie::CLI' class, write the following inside the 'Foodie::CLI' class: 

```ruby 
desc "portray ITEM", "determines if a piece of food is gross or delicious" 

def portray(name) 
  puts Foodie::Food.portray(name) 
end 
``` 

The 'desc' method is the slight difference here. The method defined after it becomes a task with a given description. The first argument for 'desc' is the usage instructions for the task whilst the second is a short description of what the task accomplishes. 

The 'portray' method defined with a single argument, which will be the first argument passed to the task on the command line. 

Inside the 'portray' method, we call 'Foodie::Food.portray' and pass it this argument. 

In the 'Foodie::CLI' class, we referene the 'Foodie::Food' class without requiring the file that defines it. Under the 'require 'thor'' at the top of the file, we add this line that defines 'Foodie::Food'. 

```ruby 
require 'foodie' 
``` 

When we re-run our features using 'bundle exec cucumber features' our first scenario will pass: 

```bash 
2 scenarios (1 failed, 1 passed) 
4 steps (1 failed, 3 passed) 
``` 

The second is failing because there's no defined 'pluralize' task. Instead of making a method that takes an argument, we define a task that reads the value from an option passed to the task. 
  -> To define the 'pluralise' task, code it into the 'Foodie::CLI' 

```ruby 
desc 'pluralize', 'Pluralize a word' 
method_option :word, aliases: '-w' 
def pluralize 
  puts Foodie::Food.pluralize(optoins[:word])
end 
``` 

^ Here, there's a 'method_option' method we use which defines a method option. It makes a hash which indicates the details of an option how they should be returned to the task. 

* Check the Thor README for a full list of valid types. 

We can also define aliases for the method using the ':aliases' option passed to 'method_option'. 

Inside the task we reference the value of the options through the 'options' hash and we use 'Foodie::Food.pluralize' to pluralize a word. 

When we run our scenarios again with 'bundle exec cucumber features' both scenarios will be passing: 

```bash 
2 scenarios (2 passed) 
4 steps (4 passed) 
``` 

We can try execurting the CLI by running 'bundle exec exe/foodie portray broccoli'. 

If we want to add more options later, we can define them by using the 'methods_options' helper: 

```ruby 
method_options word: :string, uppercase: :boolean 
def pluralize 
  # accessed as options[:word], options[:uppercase]
end 
``` 

In this example, 'options[:word]' will return a 'String' object, whilst 'options[:uppercase]' will return either 'true' or 'false', depending on the value it has received. 

