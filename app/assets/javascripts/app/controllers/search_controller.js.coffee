namespace "app.controllers", ->

    class @SearchController extends core.ApplicationModule
    
        routes:
            "search/:tag":      "search"
            "search/tag/:tag":  "search_tag"
            
        create_view_model: ( url, query_param ) ->
            new app.view_models.SearchViewModel( url, decodeURI( query_param ) )
            
        search: ( text ) =>
            search_view_model = @create_view_model( "api/search/",  text ).search( @env )
            @renderer.render_page "search/results", search_view_model
        
        search_tag: ( tag ) =>
            search_view_model = @create_view_model( "api/search/tag/",  tag ).search( @env )
            @renderer.render_page "search/results", search_view_model
                
