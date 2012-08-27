namespace "app.controllers", ->

    class @HomeController extends core.ApplicationModule
    
        routes:
            "":         "index"
            "register": "register"
            
        index: =>
            @renderer.render_page "home/index",
                new app.view_models.HomeViewModel().load( @env )
                
        register: =>
            @renderer.render_page "home/register"