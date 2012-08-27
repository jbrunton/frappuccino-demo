namespace "app.decorators", ->

    class @TagsDecorator

        # given a view model with a tags() property, returns a comma-separated string of the tags,
        # for use by inputs to edit a model's tags.
        tags_content_for: ( view_model ) ->
            ko.computed
                read: ->
                    view_model?.tags()?.join(", ")
                write: ( content ) ->
                    tags = _.map content.split(","),
                        ( tag ) -> $.trim( tag )
                    view_model.tags( tags )
                owner: view_model
