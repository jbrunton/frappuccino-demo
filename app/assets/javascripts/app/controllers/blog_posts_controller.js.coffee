namespace "app.controllers"

class app.controllers.BlogPostsController extends core.ApplicationModule

    create: (blog_id) =>
        post = @create_model( "BlogPost", blog_id: blog_id )
        post.decorate( app.decorators.TagsDecorator )
        @renderer.render_page "blog_posts/edit", post
        
    edit: (id) =>
        post = @create_model( "BlogPost" ).load id
        post.decorate( app.decorators.TagsDecorator )
        @renderer.render_page "blog_posts/edit", post
        
    view: (id) =>
        post = @create_model( "BlogPost" ).load id,
            include: { blog: { user: true } }
        post.decorate( app.decorators.MarkdownDecorator )
        @renderer.render_page "blog_posts/view", post