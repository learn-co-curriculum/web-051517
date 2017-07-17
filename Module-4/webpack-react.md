---
title: Getting started w/ React and Webpack
type: lesson
duration: 1hr 30min
creator:
  name: Tony
  city: NYC
competencies: 'package.json, webpack.config, babel.rc, react basics'
---

# Overview

Today we will cover how to start a ReactJS project from scratch using Webpack and Babel. We will then look at the benefits of ReactJS over other frameworks and why its so popular. Covering basics from JSX to creating react components.

## Objectives

1. Whats all the ReactJS hype about.
2. Setting up your dev environment.
3. First React App.
4. JSX 

### Introducing ReactJS

First thing to note is that React isn't an MVC framework. It is a library for building composable user interfaces. It encourages the creation of reusable UI components which present data that changes over time.

What does this all mean? Essentially react is the V in "MVC", it is only the view layer. It's main priority is to provide compact maintainable web components that can be used throughout multiple applications.

#### How does ReactJS work?

_How did we create our app using vanilla JS?_

We manipulated and traversed the DOM using selectors and event listeners. For example if we take a look at the Todo App, we had to create each DOM element every single time we added a new item. Doesn't this sound a little off? Imagine going to gmail and every time you check a different email you have to wait for the entire page to load. YUCK!

_So why use ReactJS?_

The DOM is slow. When we do updates or change the DOM tree think about how much work the DOM has to do. Every time the DOM changes, browser need to recalculate the CSS, do layout, and repaint the web page. This is what takes time.

**Introducing the "Virtual DOM"**

> The Virtual DOM was not invented by React, but React uses it and provides it for free.

The Virtual DOM is an abstraction of the HTML DOM. It is lightweight and detached from the browser-specific implementation details. Since the DOM itself was already an abstraction, the virtual DOM is, in fact, an abstraction of an abstraction.

What makes React and its Virtual DOM so different is that it's simpler than other approaches to making JavaScript reactive from a programmer's perspective. You write pure JavaScript that updates React components, and React updates the DOM for you. The data binding isn't intertwined with the application.

- Whenever anything may have changed, the entire UI will be re-rendered in a Virtual DOM representation.
- The difference between the previous Virtual DOM representation and the new one will be calculated.
- The real DOM will be updated with what has actually changed. This is very much like applying a patch.

![](http://lh4.ggpht.com/-C-F-YJ1BkxI/VHsE7N7U-jI/AAAAAAAAFTc/BtKDLeFxpPU/image_thumb%25255B37%25255D.png?imgmax=800)

**One-way data binding** React uses one-way data binding to make things simpler. Every time you type in an input field in a React UI, for example, it doesn't directly change the state of that component. Instead, it updates the data model, which causes the UI to be updated and the text you typed into the field appears in the field.

#### **ReactJS Data Flow** ![](http://4.bp.blogspot.com/-Friqaj4UaPw/U6FhpqhpOUI/AAAAAAAADQ0/1J1dFyEF14E/s1600/Screen+Shot+2014-06-18+at+9.50.16+AM.png) #### **MVC Data Flow** ![](http://2.bp.blogspot.com/-fZKAYompt10/U6FhqKWWqsI/AAAAAAAADQ4/qr1FrRbV_gw/s1600/Screen+Shot+2014-06-18+at+9.49.33+AM.png)

### Environment setup for ReactJS

**Babel** is a JavaScript transpiler. It turns your JavaScript into...um...JavaScript. That sounds really bizarre, so let me clarify. If you are using the latest JavaScript features, older browsers might not know what to do when they encounter a new function/property. If you are writing JSX, well...no browser will know what to do with that!

**Webpack** We'll be relying on webpack to bundle up the relevant parts of the React library, our JSX files, and any additional JavaScript into a single file. This also extends to CSS (LESS/SASS) files and other types of assets your app uses, but we'll focus on just the JavaScript side here.

#### Setting up folders

Create a project folder, call it whatever you'd like.

`mkdir dev && output`

What we are doing here is pretty simple. Inside our dev folder, we will place all of our unoptimized and unconverted JSX, JavaScript, and other script-related content. In other words, this is where the code you are writing and actively working on will live. Inside our output folder, we will place the result of running our various build tools on the script files found inside the dev folder. This is where Babel will convert all of our JSX files into JS. This is also where webpack will resolve any dependencies between our script files and place all of the important script content into a single JavaScript file.

`touch index.html`

> add the script tag to your index.html to reference the bundled js file.

### HTML in JS ???

`touch ./dev/index.jsx`

**What is JSX**

JSX is a preprocessor step that adds XML syntax to JavaScript. You can definitely use React without JSX but JSX makes React a lot more elegant.

Just like XML, JSX tags have a tag name, attributes, and children. If an attribute value is enclosed in quotes, the value is a string. Otherwise, wrap the value in braces and the value is the enclosed JavaScript expression.

> Open babel and show what happens.

Reserved words in JS - remember JSX has its own attributes to combat with these words.

### Webpack setup

First install Webpack and the dev server -

`npm install webpack webpack-dev-server --save-dev`

Next we need to configure Webpack

`touch webpack.config.js`

```javascript
var webpack = require("webpack"),
    path = require("path")

var DEV = path.resolve(__dirname, "dev")
var OUTPUT = path.resolve(__dirname, "output")

var config = {
  entry: DEV + "/index.jsx",
  output: {
    path: OUTPUT,
    filename: "myCode.js"
  }
}

module.exports = config
```

### Babel setup

Next we need Babel to help us write the newest and coolest JS available!

The last piece in our current setup is to transform our index.jsx file to become regular JavaScript in the form of myCode.js. This is where Babel comes in. To install Babel, let's go back to our trusty Terminal / Command Prompt and enter the following Node.js command:

`npm install babel-core babel-loader babel-preset-es2015 babel-preset-react --save`

Add this to your package.json file: **JS presets**

```javascript
"babel": {
   "presets": [
     "es2015",
     "react"
   ]
 }
```

The second step is to tell webpack about Babel. In our webpack.config.js file, go ahead and add the following highlighted lines:

**Loaders**

```javascript
module: {
  loaders: [{
      include: DEV,
      loader: "babel-loader",
  }]
}
```

### Lastly lets setup or Webpack dev server

```javascript
"scripts": {
  "start": "webpack && node ./node_modules/webpack-dev-server/bin/webpack-dev-server.js --hot --inline --history-api-fallback"
}
```

Now in your terminal: `npm run start` and go to localhost:8080

## React basics

## Web Components

>The dictionary definition of a component is "A part or element of a larger whole".


Well… Web Components are not actually a new thing in web development. Basically, it is a concept of reusable widgets (components) which contain an html template and can be imported in different files and used as normal HTML tags. The main intention of its creators is to make Web Components a browser standard so they won’t need any external libraries to work.

Unfortunately they are still not supported by all browsers so there is a need to use a set of polyfills – they are called webcomponentsjs

Advantages:

1. **Consistency** - Implementing reusable components helps keep design consistent and can provide clarity in organising code.
2. **Maintainability** - A set of well organised components can be quick to update, and you can be more confident about which areas will and won't be affected.
3. **Scalability** - Having a library of components to implement can make for speedy development, and ensuring components are properly namespaced helps to avoid styles and functionality leaking into the wrong place as projects scale.


Rules:

1. **Independent** - Components should be able to be used on their own and rely on only a limited set of dependencies. They should be built so they don't 'leak' or cross-over into other components.
2. **Clearly defined** - Useful but limited scope - E.g a 'button' component + a 'search box' component is better than a 'navbar' component, but a search button and search input shouldn't be split up into two separate components if they'll never be used independently.
3. **Encapsulated** - Components should 'wrap up' their functionality within themselves and provide set ways of implementation. E.g a button component could expose "size" and "colour" options.
4. **Reusable** - Components are often built with reusability in mind, although they may initially only be implemented once.


## Component Architecture


### Container components

>A container does data fetching and then renders its corresponding sub-component. That’s it.


You’ll find your components much easier to reuse and reason about if you divide them into two categories. I call them Container and Presentational components* but I also heard Fat and Skinny, Smart and Dumb, Stateful and Pure, Screens and Components, etc. These all are not exactly the same, but the core idea is similar.

- Are concerned with how things work.
- May contain both presentational and container components** inside but usually don’t have any DOM markup of their own except for some wrapping divs, and never have any styles.
- Provide the data and behavior to presentational or other container components.
- Call Flux actions and provide these as callbacks to the presentational components.
- Are often stateful, as they tend to serve as data sources.
- Are usually generated using higher order components such as connect() from React Redux, createContainer() from Relay, or Container.create() from Flux Utils, rather than written by hand.

>Examples: UserPage, FollowersSidebar, StoryContainer, FollowedUserList.


### Presentational components

- Are concerned with how things look.
- May contain both presentational and container components** inside, and usually have some DOM markup and styles of their own.
- Often allow containment via this.props.children.
- Have no dependencies on the rest of the app, such as Flux actions or stores.
- Don’t specify how the data is loaded or mutated.
- Receive data and callbacks exclusively via props.
- Rarely have their own state (when they do, it’s UI state rather than data).
- Are written as functional components unless they need state, lifecycle hooks, or performance optimizations.
Examples: Page, Sidebar, Story, UserInfo, List.



#### Benefits of this architecture

- Better separation of concerns. You understand your app and your UI better by writing components this way.
- Better reusability. You can use the same presentational component with completely different state sources, and turn those into separate container components that can be further reused.
- Presentational components are essentially your app’s “palette”. You can put them on a single page and let the designer tweak all their variations without touching the app’s logic. You can run screenshot regression tests on that page.
- This forces you to extract “layout components” such as Sidebar, Page, ContextMenu and use this.props.children instead of duplicating the same markup and layout in several container components.

![](https://cdn-images-1.medium.com/max/800/1*inU9OmAFSDYKFm8pstsCDw.png)


### Component creation

```jsx
import React, { Component } from 'react'
import ReactDOM from 'react-dom'

const HelloWorld = React.createClass({
  render: function () {
    return (
      <h1 className='myClass'>Hello, Tony</h1>
    )
  }
})

const HiWorld = () => <h1 className='myClass'>Hello, From Functional</h1>

class MyComponent extends Component {
  constructor (props) {
    super(props)
  }
  render () {
    return (
      <div>
        Hello, World
      </div>
    )
  }
}

ReactDOM.render(<MyComponent />, document.getElementById('root'))

```

sources: '<https://www.kirupa.com/react/setting_up_react_environment.htm>', '<https://www.accelebrate.com/blog/the-real-benefits-of-the-virtual-dom-in-react-js/>' ```
