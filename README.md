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
