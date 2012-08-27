namespace "app.helpers.shared", ->

    class @UrlHelper
    
        url: ( collection_name, id, action ) =>
            if id?
                "#{collection_name}/#{id}/#{action}"
            else
                "#{collection_name}/#{action}"
        
        url_for: ( resource ) =>
            if typeof resource == "object"
                collection_name = resource.collection_name
                id = resource.id()
                action = arguments[1]
            else
                collection_name = resource
                id = arguments[1]
                action = arguments[2]
            
            action ?= "view"
            
            @url( collection_name, id, action )
                
        edit_url_for: ( resource ) =>
            if typeof resource == "object"
                @url_for( resource, "edit" )
            else
                @url_for( resource, arguments[1], "edit" )
            
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