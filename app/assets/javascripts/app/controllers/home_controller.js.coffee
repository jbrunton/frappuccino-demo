namespace "app.controllers", ->

    class HomeViewModel

        constructor: ->
            @trending_tags = ko.observableArray([])
            @recent_posts = ko.observableArray([])
            
        load: ( env ) ->
            self = @
            env.load_collection "BlogPost",
                success: ( posts ) ->
                    self.recent_posts( posts )
            env.load_collection "Tag",
                url: "api/search/trending",
                success: ( tags ) ->
                    self.trending_tags( tags )
            @

    class @HomeController extends core.ApplicationModule
    
        routes:
            "":         "index"
            "register": "register"
            
        index: =>
            @renderer.render_page "home/index",
                new HomeViewModel().load( @env )
                
        register: =>
            @renderer.render_page "home/register"