namespace "app.models", ->

    class @User extends core.Model
    
        @attr {
            id: "number"
            url: "string"
        }
        
        @attr_accessible "url"