-----------------------
# Testing a generator
-----------------------
A new tool that we can use: 
```ruby 
foodie recipe dinner steak 
``` 

This generates a 'recipes' directory at the current location: 
  -> a 'dinner' directory inside that and then a 'steak.txt' file inside that. 
    • 'steak.txt' file will contain the scaffold for a recipe, such as 
      ingredients and instructions. 

Aruba has ways of testing that a generator generates files and directories. 
Let's create a new file called 'features/generator.feature' and fill it with content: 

```ruby 
Feature: Generating things 
  In order to generate many a thing 
  As a CLI newbie 
  I want foodie to hold my hand, tightly 

  Scenario: Recipes 
    When I run 'foodie recipe dinner steak' 
    Then the follwoing files should exist: 
      | dinner/steak.txt| 
    Then the file "dinner/steak.txt" should contain: 
      """ 
      ###### Ingredients ######
      Ingredients for delicious steak go here. 

      ###### Instructions ######
      Tips on how to make delicious steak go here. 
      """ 
``` 

----------------------------
#   Writing a generator 
----------------------------
Because we don't have a 'recipe' taks that does this for us defined in 'Foodie::CLI'. We can define a generator class just like we define a CLI class: 

```ruby 
desc "recipe", "Generates a recipe scaffold"
def recipe(group, name) 
  Foodie::Generators::Recipe.start([group, name])
end 
``` 

The first argument for this method are the arguments passed to the generator. We will need to require the file for this new class too, we can do this by putting this at the top of the page: 
'lib/foodie/cli.rb': 

```ruby 
require 'foodie/generators/recipe' 
``` 

To define this class, we inherit from 'Thor::Group' rather than 'Thor'. We also need to include a 'Thor::Actions' module to define helper methods for our generator which include the likes of those able to create files and directories. 

Because this is a generator class, we put it in a new namespace called 'generators', making the location of the file: 
'lib/foodie/generators/recipe.rb': 

```ruby 
require 'thor/group' 
module Foodie 
  module Generators 
    class Recipe < Thor::Group 
      include Thor::Actions 

      argument :group, type: :string 
      argument :name, type: :string 
    end 
  end 
end
``` 

By inheriting from the 'Thor::Group', we're defining a generator rather than a CLI. When we call 'argument', we are defining arguments for our generator. 

These are same arguments in the same order they are passed in from the 'recipe' task back in 'Foodie::CLI'. 

To make the generator able to generate stuff, we define methods in the class. All methods defined in a 'Thor::Group' descandant will run when 'start' is called on it. 

Let's define a 'create_group' method inside this class which will create a directory using the name we passed in. 

```ruby 
def create_group 
  empty_directory(group)
end 
``` 

To put the file in this directory and save some typing, we use the 'template' method. This will copy over a file from a pre-defined source location and evaluate it as if it were an ERB template. 

Defining a 'copy_recipe' method: 

```ruby 
def copy_recipe 
  template('recipe.txt', "#{group}/#{name}.txt")
end 
``` 

If we had any ERB calls in the file, they'd be evaluated and result would be output in the new template file. 

Run the generator by 'bundle exec exe/foodie recipe dinner steak' 

Generally, we'd test it solely through Cucumber. 

```ruby 
create  dinner
Could not find "recipe.txt" in any of your source paths. Please invoke 
Foodie::Generators::Recipe.source_root(PATH) with the PATH containing your 
templates.
Currently you have no source paths.
``` 

First line tells that the 'dinner' directory has been created. 

Second line is different, it's asking to define the 'source_root' method for generator. 
We can define it as a class method in 'Foodie::Generators::Recipe' 

```ruby
def self.source_root 
  File.dirname(__FILE__) + "/recipe" 
end 
``` 

This tells generator where to find the template. Now we create the template which we can put in 'lib/foodie/generators/recipe/recipe.txt' 

``` 
##### Ingredients #####
Ingredients for delicious <%= name %> go here.


##### Instructions #####
Tips on how to make delicious <%= name %> go here.
``` 

When we use the 'template' method, the template file is treated like an ERB template
  -> which is evaluated within the current 'binding' which means that 
    => it has access to the same methods and variables as the methods that 
       call it. 

Run 'bundle exec cucumber features' all of the features are passing. 

```bash 
3 scenarios (3 passed) 
7 steps (7 passed) 
``` 

