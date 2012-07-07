namespace "app.controllers", ->

    class @HomeController extends core.ApplicationModule
    
        routes:
            "":                     "index"
            
        # templates:
        #    "master": app.templates.master
            # "home.index": app.templates.home.index

        index: =>
            @renderer.render_page "home/index",
                trendingTags: ko.observableArray([])
                recentPosts: ko.observableArray([])
