namespace "app.modules", ->

    class @HeaderModule extends core.ApplicationModule
        @on "Application.initialize", ->
            @view_model = new app.view_models.HeaderViewModel( @sandbox )
            @sandbox.renderer.bind_default_data "header", @view_model
            