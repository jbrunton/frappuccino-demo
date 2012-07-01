namespace "infrastructure", ->

    class @BackboneRouter extends Backbone.Router
    
        navigate: ( href ) ->
            if ( href[0] == "/" )
                href = href[1..]
            
            super( href, true )
    
        constructor: ->
            self = @
            $(document).on "click", ".nav-to",
                (event) ->
                    event.preventDefault()
                    href = $(event.currentTarget).attr( "href" )
                    self.navigate( href )
