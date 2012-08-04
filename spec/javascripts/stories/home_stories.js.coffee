feature "Requiring classes with sprockets", ->

  summary(
    'As a new user to the site',
    'I should see the home page'
  )
  
  def_timeout = 2000

  scenario "Require foo and bar", ->
    
    _app = null
  
    Given "I am a new user to the site", ->
        _app = new app.Application()            
        _app.run(new app.Bootstrapper)
        Backbone.history.start()
        _app.resolve_module( "AuthModule" ).sign_out()
        
    When "I go to the home page", ->
        runs(-> _app.router.navigate("/") )

    Then "there should be a hero unit", ->
        expect( $ ".hero-unit" ).toExist()
        
    And "there should be a list of recent posts", ->
        has_posts = -> $( "#recent-posts li" ).length > 0
        # TODO: should be able to write "home_controller.active_view_model.recent_posts.loaded"
        waitsFor( has_posts, "recent posts should be loaded", def_timeout )

        runs( -> expect( $ "#recent-posts" ).toContain "li" )
    
    And "there should be a list of trending tags", ->
        has_tags = -> $( "#trending-tags .tag" ).length > 0
        waitsFor( has_tags, "trending tags should be loaded", def_timeout )
        
        runs( -> expect( $ "#trending-tags" ).toContain ".tag" )