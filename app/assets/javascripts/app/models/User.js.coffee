namespace "app.models", ->

    class @User extends core.Model
    
        @attr id: "number"
        @attr email: "string"
        @attr screen_name: "string"
        @attr bio: "string"
        @attr avatar_url: "string"
        @has_many "blogs"
        @has_many "recent_posts", underlying_type: "blog_post"
        
        @validates "email",
            presence: true,
            email: true,
            confirmation: { if: (user) -> user.is_new_record() }
        @validates "screen_name", presence: true, length: { min: 3, max: 8 }
        
        @attr_accessible "screen_name", "email", "bio", "avatar_url"