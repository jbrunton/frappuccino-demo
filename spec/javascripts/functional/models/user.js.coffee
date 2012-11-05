#= require app/models

describe "app.models.User", ->

    application = null

    beforeEach ->
        application = new core.Application
        bootstrapper = new spec.support.Bootstrapper            
        application.run( bootstrapper )
    
    it "requires a valid email", ->
        user = new app.models.User
        user.validate()
        expect( user.email.is_valid() ).toBe false
        
        user.email( "not an email" )
        user.validate()
        expect( user.email.is_valid() ).toBe false
        
        user.email( "a.valid@email.com" )
        user.validate()
        expect( user.email.is_valid() ).toBe true
        
    it "requires a screen name", ->
        user = new app.models.User
        user.validate()
        expect( user.screen_name.is_valid() ).toBe false
        
        user.screen_name( 'some_user_name' )
        user.validate()
        expect( user.screen_name.is_valid() ).toBe true
        