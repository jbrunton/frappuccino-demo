namespace "app.controllers", ->

    class @UsersController extends core.ApplicationModule
    
        routes:
            "users/:id/view":   "view_user"
            "users/:id/edit":   "edit_user"
            
        edit_user: (id) =>
            user = @create_model( "User" ).load id
            @renderer.render_page "users/edit", user
            
        view_user: (id) =>
            user = @create_model( "User", { blogs: [], recent_posts: [] } ).load id,
                includes:
                    blogs: true
                    recent_posts: true
 
            @renderer.render_page "users/view", user