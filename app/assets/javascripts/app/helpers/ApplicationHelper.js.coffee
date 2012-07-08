#= require_tree ./shared

namespace "app.helpers", ->

    class @ApplicationHelper extends core.Mixable

        @include app.helpers.shared.UrlHelper
        @include app.helpers.shared.FormHelper
        @include app.helpers.shared.AuthHelper
    
        tags_content_for: ( ctx ) ->
            ko.computed(
                read: ->
                    ctx.tags().join(", ")
                write: ( content ) ->
                    tags = _.map content.split(","),
                        ( tag ) -> $.trim( tag )
                    ctx.tags( tags )
                owner: ctx )
                
        format_date: (date) ->
            $.datepicker.formatDate( "d MM, yy", date )
