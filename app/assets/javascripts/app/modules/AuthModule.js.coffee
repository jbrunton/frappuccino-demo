namespace "app.modules", ->

    class @AuthModule extends core.ApplicationModule
    
        @on "Application.ready", ->
            @sandbox.publish "AuthModule.success", @current_user() unless !@auth_cookie()
    
        drop_cookie: ( user ) ->
            auth_token =
                user_name: user.user_name
                user_id: user.id
    
            $.cookie "auth_user",
                JSON.stringify( auth_token )
                { expires: 7, path: '/' }
    
        auth_cookie: ->
            $.cookie( "auth_user" )
    
        current_user: =>
            JSON.parse( @auth_cookie() )
            
        auth_success: ( data ) =>
            @drop_cookie( data )
            @sandbox.publish "AuthModule.success", @current_user()
    
        authenticate: ( user_name, password, opts ) ->
            self = @
            
            success = ( user ) ->
                self.auth_success( user )
                opts?.success?( user )
        
            $.ajax
                url: "/api/auth?user_name=#{user_name}&password=#{password}"
                success: success
                dataType: 'json'

        sign_out: ->
            $.cookie( "auth_user", null, { path: '/' } )
            @sandbox.publish( "AuthModule.signout" )