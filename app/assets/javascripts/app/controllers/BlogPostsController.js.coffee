namespace "app.controllers", ->

    class @BlogPostssController extends core.ApplicationModule
    
        routes:
            "blog_posts/:id/view":   "view_post"
            "blog_posts/:id/edit":   "edit_post"
            
        edit_post: (id) =>
            post = @env.create( "blog_post" ).load id
            @renderer.render_page "blog_posts/edit", post
            
        view_post: (id) =>
            post = @env.create( "blog_post" ).load id
            @renderer.render_page "blog_posts/view", post