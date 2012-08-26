namespace "app.controllers", ->

    class @BlogsController extends core.ApplicationModule
    
        routes:
            "blogs/create":         "create_blog"
            "blogs/:id/view":       "view_blog"
            "blogs/:id/edit":       "edit_blog"
            
        create_blog: (id) =>    
            # TODO: user_id = @sandbox.resolve_module("AuthModule").current_user().id();
            blog = @create_model( "Blog" )
            @renderer.render_page "blogs/edit", blog

        edit_blog: (id) =>
            blog = @create_model( "Blog" ).load id
            @renderer.render_page "blogs/edit", blog
            
        view_blog: (id) =>
            blog = @create_model( "Blog", { blog_posts: [], user: @create_model("User") } ).load id,
                includes:
                    blog_posts: true
                    user: true
            @renderer.render_page "blogs/view", blog