---
title: ActiveRecord Methods and Finders
type: lesson
duration: "1"
creator:
    name: Tony Guerrero
    city: NYC
competencies: Relational DBs
---

# ActiveRecord MethodsandFinders

### Objectives
- Rake tasks
- Setting up AR
- Migrations
- Inheriting from AR
- Query a model using AR methods
- Instantiate and create a new instance of a model
- Edit a model's attributes
- Destroy a model


### Preparation
- Write a model that inherits from ActiveRecord
- Instantiate a new instance of a class
- Describe the structure of SQL tables, rowsandcolumns

## Intro (15 mins)

So now that you've looked at what SQL can do, and you've created Ruby classes from scratch, and even models that combine the two using ActiveRecord – it's time to see all the convenience and power that this library gives you. Today we're CRUDing.


If you struggled with models and migrations or feel like what we have here isn't something you can do on your own just yet, that's okay – you just need to practice tonight.


### ORM Recap

Object-Relational-Mapper

It's critical to understand exactly what an ORM is, and by turn then gain an understanding of ActiveRecord and the things it can do for us. Imagine we have the following structure in our database:

```
//A Table for a Band
//3 columns named GIG,PAY,DATE

+------------------BAND---------------------------+
| GIG     |        PAY           |      DATE      |
|         |                      |                |
|---------+----------------------+----------------|
|   Bob's |                      |                |
|         |         $50.00       |  10/29/2012    |
|---------+----------------------+----------------|
| E.      |       $125.00        |  11/15/2012    |
|Tavern   |                      |                |
+-------------------------------------------------+
```
And in our application we have a model that looks something like:

```ruby
#A class with 3 attributes that match a table with 3 columns in our db
class Band < ActiveRecord::Base
   attr_accessor :gig,:pay,:date

end
```

## Investigate Starter Code (5 mins)

### Migrations

Above we saw the structure of a table in a database, we can see that a database table is row-column based, exactly like a spreadsheet. With respect to our rails application, how does our table get created and structured in the first place?

In other frameworks we might need to switch back and forth between the database and the code we are writing. The workflow might look something like this:

* I need to change my user model by adding a 'tel-number' to it
* Okay, make the modifications to my User model.
* Go to the database and login, update the User table to reflect the new column. Set up any necessary default values for records already existing.
* Repeat this for any other changes, always making sure everything stays in sync.

You can probably already tell that this dance is complicated. It's very easy to update one and not the other, and when applications are built this way you tend to get errors when things go out of sync.


Luckily, Active Record gives us an extremely powerful tool for dealing with the database in this regard: **Migrations**

Migrations amount to a DSL(Domain Specific Language) used for specifying changes to the database.

We need to generate the migration below in the db/migrate folder of the project.  The syntax inside this class is the DSL, or domain specific language that AR provides for specifying changes to the database.  Take the time to understand the syntax as you will need to use stand alone migrations, where you write the code inside the change method.

`touch 001_create_pizzas`

```ruby
class CreatePizzas < ActiveRecord::Migration
  def change
    create_table :pizzas do |t|
    end
  end
end

```

>Notice how the console command is snake case 'create_pizzas' and the resulting migrations class is camel case, starting with an uppercase letter.

Now what we did is create an empty table, which obviously is not very useful on it's own. We would need to add columns to this database in order to actually make use of the table. Normally we will create a table and add the initial columns with the same migration. However models change over time, and it's really **important** to know how to adjust our models as they change over time. This is the **stand alone migration**.  

So say we want to add the columns: name, sauce, cheese to our database table, we would create a migration, then fill in the code for the change statement.

```bash
#this will generate a migration with an empty change method
$ touch 002_add_columns_to_bands
```

```ruby
class AddColumnsToPizzas < ActiveRecord::Migration
  def change
    #we will add three columns to our pizzas table
    add_column :pizzas, :name, :string
    add_column :pizzas, :sauce, :string
    add_column :pizzas, :cheese, :string
  end
end
```

Dropping a table

```ruby
class DropPizzas < ActiveRecord::Migration
  def change
    remove_table :pizzas
  end
end  
```

Removing a column

```ruby
class RemoveSauceFromPizzas < ActiveRecord::Migration
  def change
    remove_column :pizzas,:sauce
  end
end  
```

Renaming a column

```ruby
class RenameSauceInPizzas < ActiveRecord::Migration
  def change
    rename_column :pizzas, :sauce, :type
  end
end  

```

### Models

All this migrating back and forth is great, but where are our models in all of this? As you may have suspected, inheriting from the ActiveRecord class is what gave us all these crazy abilities. I put the attr_accessor just to show you that we were dealing with 3 attributes, but in real life using ActiveRecord we don't even have to do that. This is what our class would look like:

```ruby
class Pizza < ActiveRecord::Base

end
```
WTF? It's empty.

Well.....it is and isn't.  There's a lot of functionality here, you just can't see it. The contents of the all important schema.rb file act as your clue that there is more here than meets the eye. ActiveRecord(hence forth abbreviated as AR) is always acutely aware of the state of your database schema...and if you have a model called Pizza(singular), which inherits from AR, and a table called Pizzas(plural i.e all your rows of Pizza objects), there is some collaboration happening.

In other words instances of your Pizza class represent rows in your Pizzas table. Your Pizza object is tracking the schema of your bands table. This is an **extremely** important concept to grasp in rails.  That's why you don't see any attributes defined on the model, the model is designed to always reflect the lastest schema. 

To put it a different way..your Pizza class( which you might create an instance of with the code directly below)...is mirroring the Pizzas table. It has properties that match the columns of your Pizzas table. **Super critical point**, let it soak in.  

All the data in your table Pizzas will be reflected in the Band object.

```ruby

#good to go with accessors for fields
pizza = Pizza.first
sauce = pizza.sauce

```
Still, the Pizza model looks pretty empty and lonely, is there anything we can do to cheer it up?? Sure.....you can, and probably always should, decorate your models.

I'll now introduce you to one of the single most important concepts in all of web development...so important in fact...that I'll bold the whole sentence: **NEVER,NEVER,NEVER trust user data.** Always ensure that your data is valid. We're lucky that AR makes this extremely easy to do, so easy in fact that there's no excuse for not doing the minimum of data validation.


```ruby
class Pizza < ActiveRecord::Base

  validates_presence_of :name #make gig required
  validates_length_of :cheese, maximum: 100 #limit the length of characters for cheese
end

```

An exhaustive list can be found [here](http://api.rubyonrails.org/classes/ActiveModel/Validations/HelperMethods.html). Please don't hesitate to use any and all that are applicable to your models :)



## Create - Codealong (10 mins)

One of the top four coolest parts of CRUD, create is when we use our model like a blueprint to make instances of the model. This is where we start filling up our database with rows of new records. Exciting stuff, so let's do this.

Let's jump ```cd``` into our pizza app and jump into our pry shell.  

```ruby
p1 = Pizza.new
#<Pizza id: nil, name: nil, sauce: nil, cheese: nil, mushrooms: nil, extra_toppings: nil, created_at: nil, updated_at: nil>
```

That's cool, but not much good when it's all empty. Let's overwrite `p1` with a pizza that has more substance.

```ruby
p1 = Pizza.create(name: "Art Lover", sauce: "red sauce", cheese: true, mushrooms: false, extra_toppings: "artichokes, chopped garlic")
```

DID YOU SEE THAT? ActiveRecord just took our ruby method (`.create`) and converted it to SQL for us! It saved it to our table as a new row, with all those attributes – all we had to do was pass it a hash.

> Just so you know, ActiveRecord also gives us setter methods for each of our attributes, so we could just as easily say `p1.cheese = false`. Then we'd just have to save it wit `p1.save`.

## Create - Independent Practice (5 minutes)

Take five minutes to create at least three more pizzas. Make them with different options – try passing in just some of our attributes, trying using setter methodsand`.save`. Get a handful of records in your database, we'll use them in the next section.


## Read - Codealong (15 minutes)

Sweet, now that we have some pizzas in our database, how do we find them again?

Well, let's start easy:

```ruby
Pizza.all
```

While technically it comes back as an "ActiveRecord Relation", it's a thin layer on top of an array, and so you could easily loop through all your pizzas and do something with each one.

What else falls under "read"?

**How about finding one particular pizza?** We hinted earlier this week at this, but ActiveRecord automatically gives each row an 'id' column and auto-increments ids for us. Which means that **a)** you should never define an id for a record, let the library do it, and **b)** _every record has it's own unique id_.

So what if we want to find Pizza #3?

```ruby
Pizza.find(3)
```

Easy as that. There are a few other easy methods you might want to know exist –

```ruby
Pizza.first
Pizza.last
```

#### The Real Querying - Where

Now, before we can move on to the **UD** in CRUD, there's a big READ we need to learn about: querying. Querying, by definition, is just a way to ask questions of our database.

Like, "Find me any pizzas where there's no cheese":

```ruby
Pizza.where(cheese: false)
```

Or, "Find me any pizzas where there's cheese **and** the sauce is called 'marinara'":

```ruby
Pizza.where(cheese:false, sauce: 'marinara')
```

Both of those get you back an array, because a `where` query is asking for _any_ records it finds. You could combine this with `.first`, `.last`, a `.each` loop, or whatever you need.

#### The Real Querying - Find

While _where_ returns you an array, _find_ returns you one item – or a 'not found' error.

```ruby
Pizza.find(794)
# ActiveRecord::RecordNotFound: Couldn't find Pizza with 'id'=794
```

Ruby's errors are actually super helpful if you read them. But let's see some that work. Obviously we just learned:

```ruby
Pizza.find(2)
```

But how about something more interesting:

```ruby
Pizza.find_by(cheese: true)
```

Now, this is interesting – it does return one, and not an array. It returns the first that it finds. If we try this, we'll see there's _more_ than one:

```ruby
Pizza.where(cheese: true).count # => 3
```

So be mindful of when you're using `where` and when you're using `find`. Both are super useful, you just have to know the difference.

## Read - Independent Practice (5 minutes)

Take five minutes again just to practice finding and querying the pizzas you've created. Try different queries, querying multiple fields, finding based on different attributes and ids. Just see what happens for a couple minutes.





## Update - Codealong (10 minutes)

Now, the wonderful act of updating a record we know exists. Let's start by grabbing one and throwing it in a variable.

```ruby
p = Pizza.last
```

Updating is easy, and we can do it in two ways, similar to our new/create earlier. The verbose way:

```ruby
p.name = "The Anchove Explosion"
p.extra_toppings = "Anchovies, anchovies, anchovies"
p.save
```

Or, we could wrap it up in a convenient single command, passing in a hash of what we want to change:

```ruby
p.update_attributes(name: "The Anchove Explosion", extra_toppings: "Anchovies, anchovies, anchovies")
```

Both will do the trick, and there's no significant difference between them.

## Update - Independent Practice (5 minutes)

Now, take five minutes to practice updating on your own. Use both methods, see which you prefer. Try changing multiple attributes and one attribute.

## Destroy - Codealong (10 minutes)

Finally, the most devastating operation, destroying. Hopefully this one's not too surprising, because there's not much else you can do besides get rid of something:

```ruby
p.destroy
```

That'll get rid of it from our database, forever.

Now, you might be tempted to call this 'delete' instead of 'destroy' – in ActiveRecord, that distinction matters. We aren't going to get too deep into it, you're welcome to research it on your own, but the difference is this:

- **Destroy**,the one you will want 99.99% of the time, gets rid of a record, and calls callbacks
- **Delete**, which you'll probably not need to use, gets rid of a record, and _doesn't_ call callbacks

Similar to the concept of JavaScript's callbacks, ActiveRecord lets us run methods if we want to when certain events happen. That's a little too deep for right now, but with a little research, you can find out plenty about it.

If you're having trouble grasping the difference, just remember: use '.destroy'.

## Conclusion (5 mins)
- What are two ways to create a new instance of a model? Can you imagine when one might be more convenient than the other?
- What are the two ways you can update a model? Can you imagine when one might be more convenient than the other?
- What's the difference between what you get back when querying with `where` and `find`?
- How do you find a certain instance of a model?
- How do you delete a model from the database?
