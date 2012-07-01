namespace "app", ->

    class @Bootstrapper extends core.Bootstrapper
    
        # TODO: remove app param, and register Renderer as a singleton type
        configure_container: ->
            container = super()
            
            # container.registerClass "Application", app.Application, singleton: true
            container.register_class "Renderer", infrastructure.KoRenderer, singleton: true
            container.register_class "Router", infrastructure.BackboneRouter, singleton: true
            container.register_class "PropertyFactory", core.types.KoPropertyFactory, singleton: true

            # TODO: move this to a resources controller which reads from the api feed
            env = container.resolve "Environment"
            
            env.defineSimpleType "number"
            env.defineSimpleType "string"
            
            env.defineResource "user", "users",
                id: "number"
                screen_name: "string"
                user_name: "string"
                email: "string"
                bio: "string"
                avatar_url: "string"
                blogs: "List[blog]"
                recent_posts: "List[blog_post]"
                
            env.defineResource "photo", "photos",
                id: "number"
                url: "string"
                
            env.defineResource "blog", "blogs",
                id: "number"
                title: "string"
                description: "string"
                content: "string"
                blog_posts: "List[blog_post]"
                
            env.defineResource "blog_post", "blog_posts"
                id: "number"
                title: "string"
                description: "string"
                address: "string"
                content: "string"
                blog_id: "number"
                
            container
            
        initialize: ->
            # random final initialization phase
            # TODO: there's probably somewhere better to put this
            ko.setTemplateEngine( new infrastructure.UnderscoreTemplateEngine( @application ) )
            _.templateSettings =
                interpolate: /\{\{(.+?)\}\}/g
                evaluate: /\{\[(.+?)\]\}/g