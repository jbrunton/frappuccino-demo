namespace "app.controllers", ->

    # TODO: proper DI
    class AuthViewModel
    
        constructor: ( @sandbox, @router ) ->
            @user_name = ko.observable()
            @password = ko.observable()
            
        signin: ->
            router = @router
            auth_module = @sandbox.resolve_module( "auth_module" )
            auth_module.authenticate @user_name(), @password(),
                success: ( user ) ->
                    router.navigate( "/" )

    class @AuthController extends core.ApplicationModule
    
        routes:
            "auth/signin":  "sign_in"
            "auth/signout": "sign_out"
            
        sign_in: =>
            auth = new AuthViewModel( @sandbox, @router )
            @renderer.render_page "auth/signin", auth
            
        sign_out: =>
            auth_module = @sandbox.resolve_module( "auth_module" )
            auth_module.sign_out()
            @router.navigate "/"