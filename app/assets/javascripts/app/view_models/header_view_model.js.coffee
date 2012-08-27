namespace "app.view_models", ->

    class @HeaderViewModel extends core.DependentObject
        @dependency router: "Router"
    
        constructor: ( @sandbox ) ->
            @search_text = ko.observable()
        
        search: =>
            @sandbox.router.navigate("/search/#{@search_text()}")
