#= require_tree ./shared

namespace "app.helpers", ->

    class @ApplicationHelper extends core.BaseObject
        @include app.helpers.shared.UrlHelper
        @include app.helpers.shared.FormHelper
        @include app.helpers.shared.AuthHelper
    
        # TODO: this should not be here..
        format_date: (date) ->
            $.datepicker.formatDate( "d MM, yy", date )

        posted_date: (blog_post) ->
            "Posted on #{@format_date blog_post.created_at()}"