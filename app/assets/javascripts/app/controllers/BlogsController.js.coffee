namespace "app.controllers", ->

    class @BlogsController extends core.ApplicationModule
    
        routes:
            "blogs/:id/view":   "view_blog"
            "blogs/:id/edit":   "edit_blog"
            
        edit_blog: (id) =>
            blog = @env.create( "blog" ).load id
            @renderer.render_page "blogs/edit", blog
            
        view_blog: (id) =>
            blog = @env.create( "blog" ).load id
            @renderer.render_page "blogs/view", blog