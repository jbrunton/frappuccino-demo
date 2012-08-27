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
