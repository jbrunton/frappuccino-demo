namespace "app.controllers", ->

    class @BlogPostsController extends core.ApplicationModule
    
        routes:
            "blogs/:id/compose":    "create_post"
            "blog_posts/:id/view":  "view_post"
            "blog_posts/:id/edit":  "edit_post"
            
        create_post: (blog_id) =>
            post = @create_model( "BlogPost", blog_id: blog_id )
            @renderer.render_page "blog_posts/edit", post
            
        edit_post: (id) =>
            post = @create_model( "BlogPost" ).load id
            post.decorate( app.decorators.TagsDecorator )
            @renderer.render_page "blog_posts/edit", post
            
        view_post: (id) =>
            post = @create_model( "BlogPost", { blog: { title: null, user: { screen_name: null } } } ).load id,
                include:
                    blog:
                        user: true
            post.decorate( app.decorators.MarkdownDecorator )
            @renderer.render_page "blog_posts/view", post