namespace "app.controllers"

class app.controllers.UsersController extends core.ApplicationModule

    edit: (id) =>
        user = @create_model( "User" ).load id
        @renderer.render_page "users/edit", user
        
    view: (id) =>
        user = @create_model( "User" ).load id,
            include: { blogs: true, recent_posts: true }

        @renderer.render_page "users/view", user