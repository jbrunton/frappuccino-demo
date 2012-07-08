namespace "app.controllers", ->

    class HomeViewModel

        constructor: ->
            @trending_tags = ko.observableArray([])
            @recent_posts = ko.observableArray([])
            
        load: ( env ) ->
            self = @
            env.load_collection "blog_post",
                success: ( posts ) ->
                    self.recent_posts( posts )
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