namespace "app.helpers.shared", ->

    class @AuthHelper extends core.EventObject
        authenticated: ko.computed
            read: ->
                $.cookie( "user_id" )?
        current_user: ko.computed
            read: ->
                $.cookie( "screen_name" )
        current_user_id: ko.computed
            read: ->
                $.cookie( "user_id" )