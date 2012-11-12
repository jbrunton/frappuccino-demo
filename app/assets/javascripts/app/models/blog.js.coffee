namespace "app.models"

class app.models.Blog extends core.Model

    @attr "id"
    @attr "title"
    @attr "description"
    @attr "content"

    @attr_serialize "title", "description", "content"

    @has_many "blog_posts"
    @belongs_to "user"
    
    @validates "title", presence: true        