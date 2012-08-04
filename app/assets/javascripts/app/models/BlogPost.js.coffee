namespace "app.models", ->

    class @BlogPost extends core.Model
    
        @attr id: "number"
        @attr title: "string"
        @attr leader: "string"
        @attr description: "string"
        @attr address: "string"
        @attr content: "string"
        @attr blog_id: "number"
        @attr tags: "List[string]"
        @attr created_at: "datetime"
        @attr updated_at: "datetime"
        @attr tags: "List[string]"
        
        @validates "title", presence: true
        
        @attr_accessible "title", "leader", "description", "address", "content", "tags", "created_at", "tags"
                