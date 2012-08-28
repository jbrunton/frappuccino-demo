# Frappuccino Demo App

Frappuccino is an opinionated, testable, platform-agnostic framework for structuring large scale JavaScript and CoffeeScript applications.  It was developed with the following principles in mind:

* **Opinionated**: code should be succinct as possible when following convention.
* **DRY**: Frappuccino encourages thin controllers and code reuse by promoting helpers, decorators and mixins.
* **Platform-agnostic, framework-agnostic and testable**: Frappuccino leverages a dependency injection container to facilitate the reuse and testing of your classes across multiple platforms (e.g. client, server, mobile apps) and for testing purposes.
* **Loosely coupled**: Frappuccino implements a modular MVC framework (with the sandbox pattern and automatic event registration) to ensure independent application modules can be loosely coupled whilst maintaining clearly defined interfaces and access methods between them.

For some background to the patterns, see my presentation on [Building Large Scale Applications](https://speakerdeck.com/u/jbrunton/p/building-testable-large-scale-applications), (and also [JavaScript Best Practices](https://speakerdeck.com/u/jbrunton/p/javascript-best-practices) for the motivation for using jQuery only as a low-level library).

## Running the demo

Clone the repo:

    git clone git@github.com:jbrunton/frappuccino-demo.git
    cd frappuccino-demo
    
Set up the database and populate it with some seed data:

    rake db:create && rake db:migrate && rake db:seed
    
And start up the server:

    rails s
    
You should now have the site running at [http://localhost:3000].

## A few points of interest

### Models

Frappuccino implements a sophisticated data model to faciliate the serialization of complex, nested resources to and from data repositories (e.g. a RESTful web API, a database or local storage), together with a validation API akin to Rails'.  For example, here's the User model:

[app/assets/javascripts/app/models/user.js.coffee](https://github.com/jbrunton/frappuccino-demo/blob/master/app/assets/javascripts/app/models/user.js.coffee)

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

[app/assets/javascripts/app/controllers/users_controller.js.coffee](https://github.com/jbrunton/frappuccino-demo/blob/master/app/assets/javascripts/app/controllers/users_controller.js.coffee)

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

Although it's not necessary to use an MVVM pattern (and, indeed, it would be completely redundant to do so for a server-side or Titanium app, for example), Frappuccino's data model is designed to work transparently with MVVM libraries.  The demo app configures the application Bootstrapper to use the KoPropertyFactory class when building models, so that the attributes on each model are observable.  Each model is therefore inherently a view model.

The rendering framework also provides a mechanism to inject view models into specific regions in the UI and to bind them to a template.  For example, the master template defines two such bindable regions:

[app/views/home/templates/_master.html.erb](https://github.com/jbrunton/frappuccino-demo/blob/master/app/views/home/templates/_master.html.erb)

```html
<div data-region="header">
</div>

<div class="content container" data-region="content">
</div>

<footer class="footer container">
    <p>A demo blogging platform for the <a target="_blank" href="https://github.com/jbrunton/better-js-core">better-js</a> framework.</p>
</footer>
```

The ```content``` region is bound by each controller action, with a call to ```@renderer.render_page()```.  But the header view model is instantiated and bound once, on the Application.initialize event (in the HeaderModule class):

[app/modules/header_module.js.coffee](https://github.com/jbrunton/frappuccino-demo/blob/master/app/assets/javascripts/app/modules/header_module.js.coffee)

```coffeescript
class @HeaderModule extends core.ApplicationModule
    @on "Application.initialize", ->
        @view_model = new app.view_models.HeaderViewModel( @sandbox )
        @sandbox.renderer.bind_default_data "header", @view_model
```

### Helpers and decorators

It's convenient to expose methods frequently used by the templating engine in reusable, testable classes.  Frappuccino implements a helper mechanism similar to Rails': for example, the header template makes use of the ```current_user_id()``` and ```url_for()``` helper methods to generate a link to the authenticated user's profile page:

[app/views/home/templates/_header.html.erb](https://github.com/jbrunton/frappuccino-demo/blob/master/app/views/home/templates/_header.html.erb)

```html
    {[ if (authenticated()) { ]}
        <li><a class="nav-to" data-bind="attr: { href: url_for( 'users', current_user_id() ) }">
            my profile</a></li>
        <li><a href="/logout">sign out</a></li>
    {[ } else { ]}
        <!-- ... -->
    {[ } ]}
```