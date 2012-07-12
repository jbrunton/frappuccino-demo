namespace "app.models", ->

    class @BlogPost extends core.Model
    
        @attr {
            id: "number"
            title: "string"
            leader: "string"
            description: "string"
            address: "string"
            content: "string"
            blog_id: "number"
            tags: "List[string]"
            created_at: "datetime"
            updated_at: "datetime"
        }
        
        @attr_accessible "title", "leader", "description", "address", "content", "tags"
                