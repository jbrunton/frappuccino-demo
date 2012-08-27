namespace "app.decorators", ->

    class @TagsDecorator

        # given a view model with a tags() property, returns a comma-separated string of the tags,
        # for use by inputs to edit a model's tags.
        tags_content_for: =>
            self = @
            ko.computed
                read: ->
                    self.tags()?.join(", ")
                write: ( content ) ->
                    tags = _.map content.split(","),
                        ( tag ) -> $.trim( tag )
                    self.tags( tags )
                owner: self
