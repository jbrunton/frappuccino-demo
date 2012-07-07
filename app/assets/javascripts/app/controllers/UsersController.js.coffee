namespace "app.controllers", ->

    class @UsersController extends core.ApplicationModule
    
        routes:
            "users/create":     "create_user"
            "users/:id/view":   "view_user"
            "users/:id/edit":   "edit_user"
            
        create_user: =>
            user = @env.create( "user" )
            @renderer.render_page "users/edit", user
            
        edit_user: (id) =>
            user = @env.create( "user" ).load id
            @renderer.render_page "users/edit", user
            
        view_user: (id) =>
            user = @env.create( "user" ).load id,
                includes:
                    blogs: true
                    recent_posts: true
 
            @renderer.render_page "users/view", user