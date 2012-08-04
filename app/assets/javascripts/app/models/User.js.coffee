namespace "app.models", ->

    class @User extends core.Model
    
        @attr id: "number"
        @attr screen_name: "string"
        @attr user_name: "string"
        @attr email: "string"
        @attr bio: "string"
        @attr avatar_url: "string"
        @attr blogs: "List[blog]"
        @attr recent_posts: "List[blog_post]"
        
        @validates "user_name", format: { with: /ababa/ }
        
        @validates "email", presence: true, email: true
        @validates "screen_name", presence: true, length: { min: 3, max: 8 }
        
        @attr_accessible "screen_name", "user_name", "email", "bio", "avatar_url"