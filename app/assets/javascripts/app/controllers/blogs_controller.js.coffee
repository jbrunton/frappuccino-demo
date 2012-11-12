namespace "app.controllers"

class app.controllers.BlogsController extends core.ApplicationModule

    create: =>    
        # TODO: user_id = @sandbox.resolve_module("AuthModule").current_user().id();
        blog = @create_model( "Blog" )
        @renderer.render_page "blogs/edit", blog

    edit: (id) =>
        blog = @create_model( "Blog" ).load id,
            include: { blog_posts: true }
        @renderer.render_page "blogs/edit", blog
        
    view: (id) =>
        blog = @create_model( "Blog" ).load id,
            include: { blog_posts: true, user: true }
        @renderer.render_page "blogs/view", blog