namespace "app.models", ->

    class @BlogPost extends core.Model
    
        @attr "id"
        @attr "title"
        @attr "leader"
        @attr "content"
        @attr "created_at", class_name: "datetime"
        @attr "updated_at", class_name: "datetime"
        
        @attr_serialize "title", "leader", "content", "tags"

        @belongs_to "blog"
        @has_many "tags", class_name: "string"

        @validates "title", presence: true