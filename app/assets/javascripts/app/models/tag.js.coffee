namespace "app.models", ->

    class @Tag extends core.Model
        @attr "tag"
        @attr "count"
        
        @attr_serialize "tag", "count"
