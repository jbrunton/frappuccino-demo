#= require app/models

describe "app.models.Blog", ->

    application = null

    beforeEach ->
        application = new core.Application
        bootstrapper = new spec.support.Bootstrapper            
        application.run( bootstrapper )

    it "requires a title", ->
        blog = new app.models.Blog
        blog.validate()
        expect( blog.title.is_valid() ).toBe false
        
        blog.title( "some title" )
        blog.validate()
        expect( blog.title.is_valid() ).toBe true
