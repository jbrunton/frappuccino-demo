# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_jbrunton = User.create(
    screen_name: 'John Brunton',
    email: 'jbrunton@zipcar.co.uk',
    bio: "software engineer for Zipcar UK, with interests in art, technology, politics, and international development.",
    avatar_url: 'https://twimg0-a.akamaihd.net/profile_images/1435862198/Screen_shot_2011-07-10_at_6.41.49_PM_reasonably_small.png'
)

blog_jbrunton = user_jbrunton.blogs.create(
    title: 'Large Scale JS Applications',
    description: 'Exploring ways to structure large scale client-side apps'
)

blog_posts_jbrunton = blog_jbrunton.blog_posts.create([
    {   title: 'Introduction',
        leader: "So what's this all about?",
        tags: [ "CoffeeScript", "MVC", "DRY"].map{ |tag| Tag.create(tag: tag) },
        content:
<<-END
This blogging platform is intended to showcase the better-js framework, which in turn is intended to demonstrate some useful techniques for writing large scale Javascript applications. This blog charts some of the significant design decisions taken and challenges encountered along the way.

## Design goals

There are a couple of key principles which guide the architecture of this application:

1. Code should adhere to the [DRY principle](http://en.wikipedia.org/wiki/Don't_repeat_yourself).
2. Authoring new pages, controllers, resources, etc. should require absolutely as little code as possible.

As a consequence of point 1, the code is necessarily loosely-coupled, with most elements being completely reusable (eg, most templates and view models), or extremely lightweight (eg, controllers).  And in most cases, both of these apply.

## Article series

1. Introduction
2. [Application Architecture](#blog_posts/2/view)
3. [Automatic Event Registration](#blog_posts/3/view)
END
    },
    {   title: 'Application Architecture',
        leader: 'A high-level description of the design patterns and architecture used.',
        tags: [ "CoffeeScript", "MVC", "Dependency Injection", "Module Pattern"].map{ |tag| Tag.create(tag: tag) },
        content:
<<-END
## Inspired by Rails

The framework is opinionated, in many of the ways that Rails is.  It provides infrastructure to support MVC applications; helper classes (application-wide on a per-controller basis) to inject reusable functionality into the rendering context; a mechanism for transmitting RESTful resources to and from the server; and lots more besides.

## Inspired by Prism

There's also one key feature to the design which Rails doesn't do.  To ensure the facilitate the easy switching of such things as templating engines, to enable reuse of the same application code on both the client or the server (or different client platforms), and to facilitate easy testing, the framework provides a dependency injection container, which will dynamically resolve dependencies for a class based on its configuration.

## The MVC parts

The most recognizable features of the architecture are probably the controllers, which, as with Rails, should be succinct and concerned only with fetching the correct resources from the server and tying them to a view.  Here's a simple example:

    class @UsersController extends core.ApplicationModule
    
        routes:
            "users/:id/view":   "view_user"
            "users/:id/edit":   "edit_user"
            
        edit_user: (id) =>
            user = @env.create( "user" ).load id
            @renderer.render_page "users/edit", user
            
        view_user: (id) =>
            user = @env.create( "user" ).load id,
                includes:
                    blogs: true
                    recent_posts: true
 
            @renderer.render_page "users/view", user

Pretty straightforward: it defines a couple of (client-side) routes; and actions for each which load a user resource from the server and render it using an appropriate template.  The ```view_user``` action also requests that the server follows the ```blogs``` and ```recent_posts``` associations and returns the results in its response.

## The module pattern

A module is simply an object which may be registered with the application, and which may listen for and raise events. A typical module might look like this:

    var loggingModule = {
        '@Application.initialize': function(app) {
            this.ready();
        },
        
        '@*.*': function(eventName) {
            console.log(eventName + ' raised');
        }
    };
    
A module may be registered with the application by use of the `app.registerModule()` method. This will make the application aware of the module, and will automatically subscribe the module to any of the events it provides handlers for.
END
    },
    {   title: 'Automatic Event Registration',
        leader: 'Beyond the mediator pattern.',
        tags: [ "Mediator", "AER" ].map{ |tag| Tag.create(tag: tag) },
        content:
"## Why not mediate?

The mediator is a well known and useful pattern for allowing unrelated units of code to communicate in a loosely-coupled fashion.  However, without due care, its use can come at the expense of clear, readable code: _anything_ can subscribe to _any event_ from _anywhere_ in the codebase at _any time_.  Clearly, such code becomes difficult to reason about and maintain.

Automatic event registration (AER) is a useful pattern which improves upon mediators in 3 distinct ways:

1. **Clarity of code**: it is clear at a glance which events a module subscribes to.  Moreover, meaningful naming conventions are enforced for events across the application.
2. **Succinct code**: with event subscriptions handled automatically, you reduce the verbosity of your initialization code. 
3. **Module permissions**: coupled with the sandbox pattern, you can easily define a permissions structure for inter-module subscriptions, to ensure dependencies are clearly expressed and carefully managed.

## What does it look like?

Each module defines handlers for the events it wishes to subscribe to.  A common naming convention is used to distinguish events: in the case of this application framework, each event is prefixed with an ```@``` sign.  The subscriptions are then wired up automatically by the application core.

Here's an example module definition:

    class @MyModule extends core.ApplicationModule
    
        foo: ->
            @sandbox.publish 'fooHappened'
            
        @on 'fooHappened', ->
            alert( 'Foo just happened' )
    
In this example, the module defines a method ```foo```, which raises the _fooHappened_ event.  The ```@fooHappened``` handler is automatically subscribed to this event.

The application core also allows communication between modules.  Events are scoped according to the publishing module - the full name of the event in the above example is actually _MyModule.fooHappened_.  Modules may - if granted permission - subscribe to events from other modules by specifying the event name in full:

    class @MyModule extends core.ApplicationModule
        ...
        @on 'AnotherModule.barHappened', ->
            alert( 'Bar just happened in AnotherModule' )
        ...

If a module attempts to subscribe to an event it doesn't have permission for, an error is raised.  See [link goes here] for more details about the permissions model."
    }
])

# tags_jbrunton = Tag.create([
#     { tag: 'large-scale', blog_post: blog_posts_jbrunton[0] },
#     { tag: 'javascript', blog_post: blog_posts_jbrunton[0] },
#     { tag: 'single-page', blog_post: blog_posts_jbrunton[0] },
#     { tag: 'javascript', blog_post: blog_posts_jbrunton[1] },
#     { tag: 'DRY', blog_post: blog_posts_jbrunton[1] },
#     { tag: 'javascript', blog_post: blog_posts_jbrunton[2] },
#     { tag: 'AER', blog_post: blog_posts_jbrunton[2] }
# ])