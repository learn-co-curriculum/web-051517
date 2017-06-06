---
title: Intro to Sinatra
type: lesson
duration: "1hr 15min"
creator:
  name: Tony
  city: NYC
competencies: MVC Ruby Frameworks
---


### Objectives
*After this lesson, students will be able to:*

- Model View Controller (MVC)
- MVC File structure in Sinatra
- Create Update Read Delete (CRUD)
- RESTful
- How to setup an entity via folders and files
- Setup the db
- Create a controller with routes
- render ERB 
- Params 


## MVC Architecture

In a typical application you will find these three fundamental parts:

- Data (Model)
An interface to view and modify the data 
- (View)
Operations that can be performed on the data 
- (Controller)
The MVC pattern, in a nutshell, is this:

The model represents the data, and does nothing else. The model does NOT depend on the controller or the view.

The view displays the model data, and sends user actions (e.g. button clicks) to the controller. The view can:

be independent of both the model and the controller; or

actually be the controller, and therefore depend on the model.

The controller provides model data to the view, and interprets user actions such as button clicks. The controller depends on the view and the model. In some cases, the controller and the view are the same object.

Rule 1 is the golden rule of MVC so I'll repeat it:

The model represents the data, and does nothing else. The model does NOT depend on the controller or the view.

![](https://www.smashingmagazine.com/images/introduction-to-rails/request.jpg)

## File Structure

>Show files and folders to students via ATOM.


## CRUD explained

Create, retrieve, update and delete (CRUD) refers to the four major functions implemented in database applications. 

The CRUD functions are the user interfaces to databases, as they permit users to create, view, modify and alter data. CRUD works on entities in databases and manipulates these entities. Any simple database table enforces CRUD constraints.

![](https://gautambiztalkblog.files.wordpress.com/2015/03/crud.jpg)

## RESTful

A RESTful application is an application that exposes its state and functionality as a set of resources that the clients can manipulate and conforms to a certain set of principles:

All resources are uniquely addressable, usually through URIs; other addressing can also be used, though.
All resources can be manipulated through a constrained set of well-known actions, usually CRUD (create, read, update, delete), represented most often through the HTTP's POST, GET, PUT and DELETE; it can be a different set or a subset though - for example, some implementations limit that set to read and modify only (GET and PUT) for example
The data for all resources is transferred through any of a constrained number of well-known representations, usually HTML, XML or JSON;
The communication between the client and the application is performed over a stateless protocol that allows for multiple layered intermediaries that can reroute and cache the requests and response packets transparently for the client and the application.


![](https://dab1nmslvvntp.cloudfront.net/wp-content/uploads/2014/06/1402203305REST_API__1.png)

## CODEALONG 

Open atom and work with a partner to follow along.

## Route Handler & Params

![](https://image.slidesharecdn.com/sinatra-flatiron-140119184501-phpapp02/95/web-development-with-sinatra-12-638.jpg?cb=1390157214)
