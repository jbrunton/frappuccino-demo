namespace "app.models", ->

    class @Blog extends core.Model
    
        @attr {
            id: "number"
            title: "string"
            description: "string"
            content: "string"
            blog_posts: "List[blog_post]"
        }
        
        @attr_accessible "title", "description", "content"
        