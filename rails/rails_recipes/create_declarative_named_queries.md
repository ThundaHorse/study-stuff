-----------------------------
# Problem: 
How do we write queries in our models so that we can best take advantage of declrative style that Rails enables? 

-----------------------------

# Solution: 

-----------------------------
Active Record's 'scope' macro allows you to declare named, composable, class-level queries on your models. But most start out writing queries directly into controllers like: 
```ruby 
# rr2/declarative_scopes/app/controllers/name.rb 
class SomethingsController < ApplicationController 
  def search 
    @wombats = Wombat.where("bio like ?", "%#{params[:q]}%").
                      order(:age) 
    render :index 
  end 
end 
``` 
This works but it breaks a cardinal rule of Rails, we put model code in the controller. 

It's bad because the reader has to drop down to another level of abstraction. We'd have to look at what the original author meant but also how it does it. 

Refactored 
```ruby 
def search 
  @wombats = Wombat.with_bio_containing(params[:q])
  render :index 
end 
``` 

What we want in controller is easily understable code without worrying how it does it. 

Active Record scopes allow you to name query fragments that can be called as class-level methods or chained and then called. 
What makes scopes even more powerful is that they can be combined. 

Active Record scopes are more expressive, easier to test, and can generate well-performing queries. 