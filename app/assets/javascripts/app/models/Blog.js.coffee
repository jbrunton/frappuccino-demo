namespace "app.models", ->

    class @Blog extends core.Model
    
        @attr "id"
        @attr "title"
        @attr "description"
        @attr "content"
        @has_many "blog_posts"
        
        @attr_serialize "title", "description", "content"
        