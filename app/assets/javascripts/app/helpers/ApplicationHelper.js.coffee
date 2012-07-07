#= require_tree ./shared

namespace "app.helpers", ->

    class @ApplicationHelper extends core.Mixable

        @include app.helpers.shared.UrlHelper
        @include app.helpers.shared.FormHelper
        @include app.helpers.shared.AuthHelper
    