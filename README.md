# Frappuccino Demo App

Frappuccino is an opinionated, testable, platform-agnostic framework for structuring large scale JavaScript and CoffeeScript applications.  It was developed with the following principles in mind:

* Opinionated: code should be succinct as possible when following convention.
* DRY: Frappuccino encourages thin controllers and code reuse by promoting helpers, decorators and mixins.
* Platform-agnostic, framework-agnostic and testable: Frappuccino leverages a dependency injection container to facilitate the reuse and testing of your classes across multiple platforms (e.g. client, server, mobile apps) and for testing purposes.
* Loosely coupled: Frappuccino implements a modular MVC framework (with the sandbox pattern and automatic event registration) to ensure independent application modules can be loosely coupled whilst maintaining clearly defined interfaces and access methods between them.

## Running the demo

Clone the repo:

    git clone git@github.com:jbrunton/frappuccino-demo.git
    
Set up the database and populate it with some seed data:

    rake db:create && rake db:migrate && rake db:seed
    
And start up the server:

    rails s
    
You should now have the site running at http://localhost:3000.

## A few points of interest

TODO: this section.

* Models and validation (e.g. User)
* Serialization and RESTful resources (e.g. UsersController)
* Helpers (e.g. url and auth helpers)
* View Models and template regions (e.g. header view model)

### Models

Frappuccino implements a sophisticated data model to faciliate the serialization of complex, nested resources to and from data repositories (e.g. a RESTful web API, a database or local storage), together with a validation API akin to Rails'.  For example, here's the User model:

```coffeescript
class @User extends core.Model

    # Attributes on the data model
    @attr "id"
    @attr "email"
    @attr "screen_name"
    @attr "bio"
    @attr "avatar_url"
    
    # Associations (which are exposed via attributes) - 'blogs' is inferred to be a list of the
    # 'Blog' data model type, and 'recent_posts' is explicitly set to be a list of BlogPosts
    @has_many "blogs"
    @has_many "recent_posts", class_name: "BlogPost"

    # The attributes which should be automatically serialized when saving/updating instances
    @attr_serialize "screen_name", "email", "bio", "avatar_url"

    # Validators
    @validates "email", presence: true, email: true
    @validates "screen_name", presence: true
```

The attributes, associations and validators are used to define the behavior of the ```validate()```, ```save()``` and ```load()``` methods on the User class.

### Serialization and RESTful resources

The UsersController defines two routes and two actions, which are, as you'd hope, extremely thin:

```coffeescript
class @UsersController extends core.ApplicationModule
    
    # note that the precise semantics of the routing are depending on the routing API you use.  the
    # demo app uses Backbone's Router class
    routes:
        "users/:id/view":   "view_user"
        "users/:id/edit":   "edit_user"

    # load an instance of the specified user from the server (including the 'blogs' and
    # 'recent_posts' associations), and bind the data model to the 'users/view' template
    view_user: (id) =>
        user = @create_model( "User" ).load id,
            include: { blogs: true, recent_posts: true }
        @renderer.render_page "users/view", user

    # load an instance of the specified user (without the associations this time) and bind the data
    # model to the 'users/edit' template
    edit_user: (id) =>
        user = @create_model( "User" ).load id
        @renderer.render_page "users/edit", user
```            

### View models and template binding

### Helpers and decorators

It's convenient to expose methods frequently used by the templating engine in reusable, testable classes.  Frappuccino implements a helper mechanism similar to Rails': for example, the header template makes use of the ```current_user_id()``` and ```url_for``` helper methods to generate a url to the authenticated user's profile page:

```html
    {[ if (authenticated()) { ]}
        <li><a class="nav-to" data-bind="attr: { href: url_for( 'users', current_user_id() ) }">
            my profile</a></li>
        <li><a href="/logout">sign out</a></li>
    {[ } else { ]}
        <!-- ... -->
    {[ } ]}
```