namespace "app.decorators"

# given a view model with a tags() property, provides a writable computed property "tags_csv", a
# comma-separated string of the tags, for use by inputs to edit a model's tags.
#
class app.decorators.TagsDecorator

    constructor: ->
        @tags_content = ko.computed
            read: ->
                @tags_as_csv( @tags?() )
            write: ( text ) ->
                @tags?( @tags_from_csv( text ) )
            owner: @

    tags_as_csv: ( tags ) ->
        tags?.join(",")
        
    tags_from_csv: ( text ) ->
        _.map text.split(","), ( tag ) ->
            $.trim( tag )

    