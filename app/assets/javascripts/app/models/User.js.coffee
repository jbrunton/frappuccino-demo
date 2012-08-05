namespace "app.models", ->

    class @User extends core.Model
    
        @attr id: "number"
        @attr email: "string"
        @attr screen_name: "string"
        @attr bio: "string"
        @attr avatar_url: "string"
        @has_many "blogs"
        @has_many "recent_posts", underlying_type: "blog_post"
        @attr password: "string"
        
        @validates "email", presence: true, email: true
        @validates "screen_name", presence: true
        @validates "password", presence: true, length: { min: 5 }, confirmation: true
        
        @attr_accessible "screen_name", "email", "bio", "avatar_url"