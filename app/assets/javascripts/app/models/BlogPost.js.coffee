namespace "app.models", ->

    class @BlogPost extends core.Model
    
        @attr "id"
        @attr "title"
        @attr "leader"
        @attr "description"
        @attr "address"
        @attr "content"
        @attr "created_at", class_name: "datetime"
        @attr "updated_at", class_name: "datetime"
        
        @has_many "tags", class_name: "string"

        @validates "title", presence: true
        
        @attr_serialize "title", "leader", "description", "address", "content", "tags", "created_at"
                