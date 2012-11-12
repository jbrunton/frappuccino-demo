namespace "app.models"

class app.models.BlogPost extends core.Model

    @attr "id"
    @attr "title"
    @attr "leader"
    @attr "content"
    @attr "created_at", class_name: "datetime"
    @attr "updated_at", class_name: "datetime"
    
    @belongs_to "blog"
    @has_many "tags", class_name: "string"

    @attr_serialize "title", "leader", "content", "tags", "blog_id"

    @validates "title", presence: true