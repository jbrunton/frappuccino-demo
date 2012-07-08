namespace "app.controllers", ->

    class TagSearchViewModel
        constructor: ->
            @tag = ko.observable()
            @results = ko.observableArray()
            
        search: ( tag, env ) ->
            self = @
            @tag( tag )
            env.load_collection "blog_post",
                url: "api/search/tag/#{tag}",
                success: ( posts ) ->
                    self.results( posts )
            @
    
    class @SearchController extends core.ApplicationModule
    
        routes:
            "search/tag/:tag":  "search_tag"
            
        search_tag: ( tag ) =>
            @renderer.render_page "search/tag",
                new TagSearchViewModel().search( decodeURI( tag ), @env )