namespace "app.helpers.shared", ->

    class @AuthHelper extends core.EventObject
        authenticated: ko.observable( false )
        current_user: ko.observable()

        @on "AuthModule.success", ( user ) ->
            @authenticated( true )
            @current_user( user )
        
        @on "AuthModule.signout", ( user ) ->
            @authenticated( false )
            @current_user( null )