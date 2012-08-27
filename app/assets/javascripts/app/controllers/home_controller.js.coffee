namespace "app.controllers", ->

    class @HomeController extends core.ApplicationModule
    
        routes:
            "":         "index"
            "register": "register"
            
        index: =>
            home_view_model = new app.view_models.HomeViewModel().load( @env )
            @renderer.render_page "home/index", home_view_model
                
        register: =>
            @renderer.render_page "home/register"