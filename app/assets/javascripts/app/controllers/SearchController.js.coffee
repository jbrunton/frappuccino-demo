namespace "app.controllers", ->

    class SearchViewModel
        constructor: ( @url ) ->
            @query = ko.observable()
            @results = ko.observableArray()
            
        search: ( query, env ) ->
            self = @
            @query( query )
            env.load_collection "BlogPost",
                url: "#{@url}#{query}",
                success: ( posts ) ->
                    self.results( posts )
            @
    
    class @SearchController extends core.ApplicationModule
    
        routes:
            "search/:tag":      "search"
            "search/tag/:tag":  "search_tag"
            
        search: ( text ) =>
            @renderer.render_page "search/results",
                new SearchViewModel("api/search/").search( decodeURI( text ), @env )
        
        search_tag: ( tag ) =>
            @renderer.render_page "search/results",
                new SearchViewModel("api/search/tag/").search( decodeURI( tag ), @env )
                
