# Domain Modeling and Object Relationships

## Objectives / SWBATs

1. Understand what a model is and what a domain model is
2. Create classes that can interact with each other

### Domain Modeling

+ Simply put, what is a model? It's just a representation of something in the real world
+ In web development, a model is a representation of the data in our application
+ The domain model is the representation of all the data in our application
  + Can get complex very quickly - you could teach a whole course on it

### Twitter Example

+ Start by making a class to represent a tweet. Ask what properties it might have?
+ Start by giving a tweet a `username` and a `message`. Both point to strings.
+ It doesn't make sense to represent users by strings - they should have their own domain.
+ Create the user class - user has a username.

### OO School Lab

+ Start with a Simple domain - we just want to model out a school.
+ Everything will be an attribute of the school
  + The 'roster' we'll model out using a hash of of student names

### Relationships

+ Really, the student should be separate - we may want to have more information about the student
+ Age, hometown
  + A person is more than their name
  + Relationships to other things
+ So let's add a student model
  + This will mean more code, but this should be more flexible and easier to change for the future
