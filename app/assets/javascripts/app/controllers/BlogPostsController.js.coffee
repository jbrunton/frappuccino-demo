namespace "app.controllers", ->

    class @BlogPostsController extends core.ApplicationModule
    
        routes:
            "blogs/:id/compose":    "create_post"
            "blog_posts/:id/view":  "view_post"
            "blog_posts/:id/edit":  "edit_post"
            
        create_post: (blog_id) =>
            post = @env.create( "blog_post", blog_id: blog_id )
            @renderer.render_page "blog_posts/edit", post
            
        edit_post: (id) =>
            post = @env.create( "blog_post" ).load id
            @renderer.render_page "blog_posts/edit", post
            
        view_post: (id) =>
            post = @env.create( "blog_post" ).load id
            @renderer.render_page "blog_posts/view", post