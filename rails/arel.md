# ActiveRecord Queries with Arel

---

Arel is a library introduced in Rails 3 for conducting SQL queries.

Whenever you pass a `where` hash, it goes through Arel eventually. Rails exposes this with a public API that we can hook into when we need to build a more complex query.

Reasons to avoid using SQL string literals:

- Abstraction/reuse
- Readability
- Reliability
- Repetition

Example

```ruby
class Users < ActiveRecord::Base
  def groups
    @users = User.groups.where("something = false OR id IN ?", visitor.group_ids)
  end
end
```

The method Rails provides to access the underlying Arel interface is called `arel_table`. When working with another class’s table, the code may become more readable if we assign a local variable or create a method to access the table.

```ruby
def table
  Group.arel_table
end
```

`Arel::Table` object acts like a hash which contains each column on the table. The columns given by Arel are a type of node.

- it has several methods available on it to construct queries

```ruby
class ProfileGroupMemberships < Struct.new(:user, :visitor)
  def groups
    @groups ||= user.groups.where(public.or(shared_membership))
  end

# Struct a built-in class which basically acts a little like a normal custom user-created class
# It provides some nice default functionality and shortcuts when you don't need a full-fledged class.

  private

  def public
    table[:private].eq(false)
  end

  def shared_membership
    table[:id].in(visitor.group_ids)
  end

  def table
    Group.arel_table
  end
end
```

• Struct can be used as a testing stub, temporary data structure, or as internal class data
• Good rule of thumb is to break out a method anywhere the word `AND` or `OR` is used, or when something is wrapped in parenthesis

The body of our `public` groups method now also describes the business logic we want, as opposed to how it is implemented.
