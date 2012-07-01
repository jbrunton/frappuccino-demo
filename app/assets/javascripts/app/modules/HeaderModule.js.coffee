namespace "app.modules", ->

    class @HeaderModule extends core.ApplicationModule
        
        @on "Application.initialize", (app) ->
            @sandbox.renderer.bind_default_data "header",
                authenticated: -> true
                first_name: -> "John"