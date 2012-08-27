#= require_tree ./shared

namespace "app.helpers", ->

    class @ApplicationHelper extends core.BaseObject
        @include app.helpers.shared.UrlHelper
        @include app.helpers.shared.FormHelper
        @include app.helpers.shared.AuthHelper
    
        format_date: (date) ->
            $.datepicker.formatDate( "d MM, yy", date )

        # TODO: this is the hackiest thing ever
        search: (form) ->
            search_text = $(form).find("input").val()
            _app.router.navigate("/search/#{search_text}")
