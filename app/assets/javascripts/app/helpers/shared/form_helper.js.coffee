namespace "app.helpers.shared", ->

    class @FormHelper extends core.DependentObject
        @dependency router: "Router"
    
        submit_action: (resource) =>
            success = (res) => @router.navigate( @url_for( res ) ) 
            ->
                if resource.validate()
                    @save success: success

        # TODO: put this in a separate helper!            
        start_slideshow: ->
            $("#slideshow").modal( "show" )
            
            index = $( arguments[1].currentTarget ).attr( "index" )
            index ?= 0

            if @galleria?
                @galleria.data('galleria').show( index )
            else
                @galleria = $( "#galleria" ).galleria( show: index, pause: true )