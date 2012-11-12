namespace "app.helpers"

class app.helpers.ApplicationHelper extends core.DependentObject
    @dependency router: "Router"

    # authentication
    
    authenticated: ->
        $.cookie( "user_id" )?
    
    current_user: ->
        $.cookie( "screen_name" )

    current_user_id: ->
        $.cookie( "user_id" )
            
    # forms
    
    submit_success: ( model ) =>
        @router.navigate( @url_for model )
    
    submit_action: ( model ) =>
        => model.save success: @submit_success unless !model.validate()

    # TODO: this should not be here..
    format_date: (date) ->
        $.datepicker.formatDate( "d MM, yy", date )

    posted_date: (blog_post) ->
        "Posted on #{@format_date blog_post.created_at()}"
        
    # urls
    
    url_for: =>
        if typeof arguments[0] == "object"
            [model, action] = arguments
            collection_name = model.collection_name
            id = model.id()
        else
            [collection_name, id, action] = arguments
        
        if id?
            action ?= "view"
            "#{collection_name}/#{id}/#{action}"
        else
            if action?
                "#{collection_name}/#{action}"
            else
                collection_name
            
    edit_url_for: =>
        if typeof arguments[0] == "object"
            @url_for( arguments[0], "edit" )
        else
            @url_for( arguments[0], arguments[1], "edit" )
        
    email_url: ( email ) =>
        "mailto:#{email}"

    # TODO: this is only used by the auth redirect right now, which expects urls to include the
    # hash.  the result won't be suitable for use by the client router in this format - will
    # need to parameterize.
    current_url: (encode) ->
        match = window.location.href.match(/http:\/\/\w+:?\d*(\/#.*)/)
        if match?
            url = match[1]
        else
            url = '/'
        if encode
            url = encodeURIComponent(url)
        url