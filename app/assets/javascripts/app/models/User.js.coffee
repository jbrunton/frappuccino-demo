namespace "app.models", ->

    class @User extends core.Model
    
        @attr {
            id: "number"
            screen_name: "string"
            user_name: "string"
            email: "string"
            bio: "string"
            avatar_url: "string"
            blogs: "List[blog]"
            recent_posts: "List[blog_post]"
        }
        
        @attr_accessible "screen_name", "user_name", "email", "bio", "avatar_url"