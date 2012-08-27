namespace "app.view_models", ->

    class @SearchViewModel
        constructor: ( @url, query ) ->
            @query = ko.observable(query)
            @results = ko.observableArray()
            
        update_results: ( posts ) =>
            @results( posts )
            
        search: ( env, query ) ->
            query ?= @query()
            @query( query )
            
            env.load_collection "BlogPost",
                url: "#{@url}#{query}",
                success: @update_results
                
            return @
    