namespace "app", ->

        class @Application extends core.Application
    
            run: ( bootstrapper_class ) ->
                bootstrapper = super( bootstrapper_class )
                bootstrapper.initialize()
