namespace "app", ->

        class @Application extends core.Application
    
            run: ( bootstrapper ) ->
                bootstrapper = super( bootstrapper )
                bootstrapper.initialize()
