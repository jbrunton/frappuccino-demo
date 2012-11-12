namespace "app"

class app.Application extends core.Application

    run: ( bootstrapper ) ->
        bootstrapper = super( bootstrapper )
        bootstrapper.initialize()
