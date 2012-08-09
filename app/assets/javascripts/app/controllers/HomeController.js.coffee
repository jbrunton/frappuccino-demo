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
            "":                     "index"
            
        # templates:
        #    "master": app.templates.master
            # "home.index": app.templates.home.index

        index: =>
            @renderer.render_page "home/index",
                new HomeViewModel().load( @env )