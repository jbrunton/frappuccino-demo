#= require app/helpers/application_helper

describe "app.helpers.ApplicationHelper", ->

    application_helper = null

    beforeEach ->
        application_helper = new app.helpers.ApplicationHelper

    describe "#url_for", ->
    
        model = null
        
        beforeEach ->
            model =
                id: -> 1
                collection_name: "users"
    
        it "returns the url for a specific resource", ->
            url = application_helper.url_for( model )
            expect( url ).toEqual "users/1/view"
            
        it "allows the action to be overridden", ->
            url = application_helper.url_for( model, 'edit' )
            expect( url ).toEqual "users/1/edit"
            
        it "returns the url for a specific collection if no model is provided", ->
            url = application_helper.url_for( 'users', null )
            expect( url ).toEqual "users"
