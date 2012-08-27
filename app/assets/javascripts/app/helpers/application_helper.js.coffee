#= require_tree ./shared

namespace "app.helpers", ->

    class @ApplicationHelper extends core.BaseObject
        @include app.helpers.shared.UrlHelper
        @include app.helpers.shared.FormHelper
        @include app.helpers.shared.AuthHelper
    
        tags_content_for: ( ctx ) ->
            ko.computed(
                read: ->
                    ctx?.tags()?.join(", ")
                write: ( content ) ->
                    tags = _.map content.split(","),
                        ( tag ) -> $.trim( tag )
                    ctx.tags( tags )
                owner: ctx )
                
        format_date: (date) ->
            $.datepicker.formatDate( "d MM, yy", date )

        # TODO: this is the hackiest thing ever
        search: (form) ->
            search_text = $(form).find("input").val()
            _app.router.navigate("/search/#{search_text}")
            
        current_url: (encode) ->
            match = window.location.href.match(/http:\/\/\w+:?\d*(\/#.*)/)
            if match?
                url = match[1]
            else
                url = '/'
            if encode
                url = encodeURIComponent(url)
            url