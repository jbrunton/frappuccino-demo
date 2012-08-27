namespace "app.view_models", ->

    class @HomeViewModel

        constructor: ->
            @trending_tags = ko.observableArray([])
            @recent_posts = ko.observableArray([])
            
        update_recent_posts: ( posts ) =>
            @recent_posts( posts )
            
        update_trending_tags: ( tags ) =>
            @trending_tags( tags )
            
        load: ( env ) ->
            env.load_collection "BlogPost",
                success: @update_recent_posts

            env.load_collection "Tag",
                url: "api/search/trending",
                success: @update_trending_tags

            return @