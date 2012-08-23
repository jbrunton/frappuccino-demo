namespace "app.controllers", ->

    class @UsersController extends core.ApplicationModule
    
        routes:
            "users/create":     "create_user"
            "users/:id/view":   "view_user"
            "users/:id/edit":   "edit_user"
            
        create_and_submit_user: ( user ) =>
            router = @router
            auth_module = @sandbox.resolve_module( "auth_module" )
            
            if user.validate()
                user.save success: ( _user ) ->
                    auth_module.authenticate user.email(), ""
                    router.navigate( "/users/" + _user.id() + "/view" )
                
            
        create_user: =>
            router = @router

            user = _.extend @create_model( "User" ),
                submit: @create_and_submit_user
            
            @renderer.render_page "users/edit", user
            
        edit_user: (id) =>
            user = @create_model( "User" ).load id
            @renderer.render_page "users/edit", user
            
        view_user: (id) =>
            user = @create_model( "User", { blogs: [], recent_posts: [] } ).load id,
                includes:
                    blogs: true
                    recent_posts: true
 
            @renderer.render_page "users/view", user