namespace "app.models", ->

    class @Tag extends core.Model
        @attr {
            tag: "string"
            count: "number"
        }
        
        @attr_accessible "tag", "number"
