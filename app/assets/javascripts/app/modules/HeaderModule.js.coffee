namespace "app.modules", ->

    class HeaderViewModel
    
        constructor: ( @sandbox ) ->
            #@authenticated = ko.observable( true )
            @user_name = ko.observable()
            @user_id = ko.observable()
            
            @form_user_name = ko.observable()
            @form_password = ko.observable()
        
        sign_in: ->
            auth_module = @sandbox.resolve_module( "AuthModule" )
            auth_module.authenticate @form_user_name(), @form_password()
            
            @form_user_name( null )
            @form_password( null )

    class @HeaderModule extends core.ApplicationModule
    
        @on "AuthModule.success", ( user ) ->
            #@user.authenticated( true )
            @user.user_name( user.user_name )
            @user.user_id( user.user_id )
            
        @on "AuthModule.signout", ->
            #@user.authenticated( false )
            @user.user_name( null )
            @user.user_id( null )
        
        @on "Application.initialize", (app) ->
            @user = new HeaderViewModel( @sandbox )
            @sandbox.renderer.bind_default_data "header", @user