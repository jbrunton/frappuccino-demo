#= require_tree ./shared

namespace "app.helpers", ->

    class @ApplicationHelper extends core.BaseObject
        @include app.helpers.shared.UrlHelper
        @include app.helpers.shared.FormHelper
        @include app.helpers.shared.AuthHelper
    
        # TODO: this should not be here..
        format_date: (date) ->
            $.datepicker.formatDate( "d MM, yy", date )
