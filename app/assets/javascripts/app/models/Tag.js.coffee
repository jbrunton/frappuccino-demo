namespace "app.models", ->

    class @Tag extends core.Model
        @attr tag: "string"
        @attr count: "number"
        
        @attr_accessible "tag", "count"
