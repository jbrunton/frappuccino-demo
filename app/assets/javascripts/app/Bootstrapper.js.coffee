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


            formatDate = (date) ->
                if date
                    date.toString()
                else
                    null
        
            parseDate = (value) ->
                # 2012-03-15T23:02:29Z
                regex = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})Z$/
        
                if (value)
                    match = value.match(regex)
                    new Date(
                        parseInt(match[1]),
                        parseInt(match[2]),
                        parseInt(match[3]),
                        parseInt(match[4]),
                        parseInt(match[5]),
                        parseInt(match[6]))
                else
                    null

            env.defineSimpleType "datetime", formatDate, parseDate
            
            env.defineResource "user", "users",
                attr:
                    id: "number"
                    screen_name: "string"
                    user_name: "string"
                    email: "string"
                    bio: "string"
                    avatar_url: "string"
                    blogs: "List[blog]"
                    recent_posts: "List[blog_post]"
                attr_accessible: [ "screen_name", "user_name", "email", "bio", "avatar_url" ]
                
            env.defineResource "photo", "photos",
                attr:
                    id: "number"
                    url: "string"
                attr_accessible: [ "url" ]
                
            env.defineResource "blog", "blogs",
                attr:
                    id: "number"
                    title: "string"
                    description: "string"
                    content: "string"
                    blog_posts: "List[blog_post]"
                attr_accessible: [ "title", "description", "content" ]
                
            env.defineResource "blog_post", "blog_posts",
                attr:
                    id: "number"
                    title: "string"
                    leader: "string"
                    description: "string"
                    address: "string"
                    content: "string"
                    blog_id: "number"
                    tags: "List[string]"
                    created_at: "datetime"
                    updated_at: "datetime"
                attr_accessible: [ "title", "leader", "description", "address", "content", "tags" ]
                
            env.defineResource "tag", "tags",
                attr:
                    tag: "string"
                    count: "number"
                attr_accessible: [ "tag", "number" ]
                
            container
            
        initialize: ->
            # random final initialization phase
            # TODO: there's probably somewhere better to put this
            ko.setTemplateEngine( new infrastructure.UnderscoreTemplateEngine( @application ) )
            _.templateSettings =
                interpolate: /\{\{(.+?)\}\}/g
                evaluate: /\{\[(.+?)\]\}/g