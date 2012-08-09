namespace "app.models", ->

    class @Photo extends core.Model
    
        @attr "id"
        @attr "url"
        
        @attr_serialize "url"