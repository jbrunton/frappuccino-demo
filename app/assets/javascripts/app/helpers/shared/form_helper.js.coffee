namespace "app.helpers.shared", ->

    class @FormHelper extends core.DependentObject
        @dependency router: "Router"
    
        submit_action: (resource) =>
            success = (res) => @router.navigate( @url_for( res ) ) 
            ->
                if resource.validate()
                    @save success: success
