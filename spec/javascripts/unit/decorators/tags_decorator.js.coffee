#= require app/decorators/tags_decorator

describe "app.decorators.tags_decorator", ->

    tags_decorator = null
    
    beforeEach ->
        tags_decorator = new app.decorators.TagsDecorator

    describe "#tags_as_csv", ->
    
        it "given a list of tags, returns a CSV string", ->
            csv_value = tags_decorator.tags_as_csv( ['foo', 'bar'] )
            expect( csv_value ).toEqual 'foo,bar'
            
        it "given an empty list, returns the empty string", ->
            expect( tags_decorator.tags_as_csv( [] ) ).toEqual ""

    describe "#tags_from_csv", ->
    
        it "given a csv value, returns a list of (trimmed) tags", ->
            csv_value = tags_decorator.tags_from_csv( 'foo, bar' )
            expect( csv_value ).toEqual ['foo', 'bar']

    describe "#tags_content", ->

        target = null
    
        beforeEach ->
            target =
                tags: ko.observable()

        it "adds a 'tags_content' computed property to its target", ->                
            target.tags( ['foo', 'bar'] )
            core.decorate target, app.decorators.TagsDecorator
            expect( target.tags_content() ).toEqual 'foo,bar'
        
        it "the 'tags_content' computed property is writable", ->                
            core.decorate target, app.decorators.TagsDecorator
            target.tags_content( 'foo, bar' )
            expect( target.tags() ).toEqual ['foo', 'bar']
        