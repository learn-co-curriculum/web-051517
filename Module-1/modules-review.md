---
title: Ruby Modules Review
type: lesson
duration: "1hr"
creator:
    name: Yomi Lajide
    city: NYC
competencies: Ruby Modules
---

## Objectives
1. Basics of ruby Modules, nested modules/Module namespacing.
2. Refactoring using modules.

### Ruby Modules
Modules allow us to collect and bundle a group of methods and make those methods available to any number of classes.

But why modules? Simple, if you find yourself copying and pasting the same lines of code everywhere...wouldn't it be smart to find a solution that can scale.

Modules are similar to Classes when it comes the inheritance chain, except you can include/extend/prepend multiple modules, and you can not instantiate a module.

Example of a Module.

```ruby
module FlatIronSchool
	def accept_Student
		puts "Welcome to Flatiron School"
	end
end
```

### Things we can do with this module within a class:
- _include_ the module within out class: allows our classes to use all of the methods of the included module as instance methods.
- _extend_ our module into our class: this lends a module's methods to the class as class methods.
- _prepend_ our module to our class: makes the methods from the module **"stronger"** and executes them first.

<!--
include: _Instance methods_.  
extend: _Class methods_.
-->


Utilizing modules within classes.

```ruby
require_relative "RELATIVE FILE PATH"(# in this instance the file path pointing to my FlatIronSchool module)

class Module1
	extend FlatIronSchool
end

Module1.accept_Student => "Welcome to Flatiron School"
```

If we had _included_ the module instead of _extended_ the module. What would we have done differently?

Lets refactor some code using modules. [To the Lab!](https://learn.co/tracks/web-development-immersive-2-0-module-one/object-oriented-ruby/object-architecture/intro-to-modules-lab)

Before you start refactoring ask yourself:

- What is the responsibility or the behavior of the code we are trying to extract?

Class method

```ruby
def self.reset_all
    @@songs.clear
  end

  def self.count
    self.all.count
  end
```


Module method

```ruby
module Memorable

  def reset_all
    self.all.clear
  end

  def count
    self.all.count
  end

end
```

- Why have we gotten rid of _self_ in the module methods?

Class method

```ruby
  	def self.find_by_name(name)
     @@songs.detect{|a| a.name == name}
   end
```

Module method

```ruby
module Findable

  def find_by_name(name)
    self.all.detect{|a| a.name == name}
  end

end
```

- Now we need to either inlcude or extend this module into our classes to have access to this method.

class method

```ruby
def to_param
    name.downcase.gsub(' ', '-')
end
```
module method

```ruby
module Paramable
  def to_param
    name.downcase.gsub(' ', '-')
  end
end
```
- Now we need to either inlcude or extend this module into our classes to have access to this method.

For the next part we will need to incorporate the concept of nested modules and namespacing.

Example of nested modules and namespacing.

```ruby
module FlatIronSchool
	module Instructors
		def early_morning_action
			puts "deploy labs"
		end
	end

	module Administration
		def accept_Student
			puts "Welcome to Flatiron School"
		end
	end

	module Students
		def pick_a_name
			puts "we are awesome!"
		end
	end

	class New_Students
		puts "here to learn"
	end
end
```


```ruby
class Module1
	extend FlatIronSchool::Students
end
```
The `Parent::Child` syntax is called **namespacing**

**NOW WHAT?**

how do we access that class?

```ruby
class Module1
	extend FlatIronSchool
  john = FlatIronSchool::NewStudents::Module1.new
end
  or
class Module1 < FlatIronSchool::NewStudents

end
```

```ruby
module Memorable

module InstanceMethods
  def initialize
    self.class.all << self
  end
end

module ClassMethods
  def reset_all
    self.all.clear
  end

  def count
    self.all.count
  end
end

end

```

In our Artist/Song Class we have to change how we are referencing the module.

```ruby
  extend Memorable::ClassMethods, Findable
  include Paramable, Memorable::InstanceMethods
```

Before we continue you will have to add one more line of code to the artist initialize method.

```ruby
def initialize
	super
	@songs = [ ]
end
```
The super is looking for a parent method _initialize_ and adding its functionality to the current instance method.


[Ruby modules vs poro](https://www.google.com/webhp?hl=en&sa=X&ved=0ahUKEwiI3IfVm_zTAhVErlQKHUUnALgQPAgD#hl=en&q=ruby+modules+vs+poro)

Poro: Plain old Ruby object.

prepend vs include in super.

```ruby
class New_Instructor
	include FlatIronSchool::Instructors
	def early_morning_action
		puts "Smile, its a lovely day"
		super()
	end
end

```

what happens if we change that include to _prepend_?
_prepend_ guarantees the parent method is called before this instance method.
_____

### EXTRA
Popular Atom Shortcuts!

rw tab:  attr_accessor :attr_names  
r tab:  attr_reader :attr_names  
w:  attr_writer :attr_names  
dfi tab:  def initialize argument end  
def tab: def method end  
defs tab: def self.method end

cl tab:  class  Name  end  
mod tab:  module Name end  
c tab: case statements  
if tab: if statements  
el tab: elsif statements
e tab: each {|e|}   
m tab: map {|e|}  
f tab: find{|f|}  


I think you get the idea on these, just try hitting a button and seeing the drop down menu, you will be pleasantly surprised. These are automatically determined by the file type you are in. So, it will change with all programming languages that atom supports.

&#8984; + / --> comment.   
&#8984; + , --> settings.  
&#8984; + d --> select matching words (&#8984; + click works too)  
&#8984; + \ --> hides file tree.  
&#8984; + [ or &#8984; + ] --> auto indents or reverses indent relative to parent scope.
i while file tree is selected will show hidden files.  
a while file tree is selected will add a new file.  
shift + a will add a new folder.  
____
