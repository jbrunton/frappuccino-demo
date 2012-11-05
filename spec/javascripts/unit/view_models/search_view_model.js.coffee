#= require app/view_models/search_view_model

describe "app.view_models.SearchViewModel", ->

    search_view_model = null

    beforeEach ->
        search_view_model = new app.view_models.SearchViewModel "http://some.url.com/search/"

    it "queries and loads a collection in response to a query", ->    
        env = jasmine.createSpyObj 'env', ['load_collection']
            
        search_view_model.search env, "query?param=foo"        
        expect( env.load_collection ).toHaveBeenCalledWith 'BlogPost',
            url: "http://some.url.com/search/query?param=foo"
            success: search_view_model.update_results

    it "updates the 'results' array one receiving a response", ->
        search_view_model.update_results ['some', 'results']
        expect( search_view_model.results() ).toEqual ['some', 'results']
