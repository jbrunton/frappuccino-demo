namespace "app.models", ->

    class @User extends core.Model
    
        @attr "id"
        @attr "email"
        @attr "screen_name"
        @attr "bio"
        @attr "avatar_url"
        @has_many "blogs"

        @has_many "recent_posts", class_name: "BlogPost"
        
        @validates "email", presence: true, email: true
        @validates "screen_name", presence: true
        
        @attr_serialize "screen_name", "email", "bio", "avatar_url"