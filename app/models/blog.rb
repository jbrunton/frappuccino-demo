class Blog < ActiveRecord::Base
    attr_accessible :title, :description

    belongs_to :user
    has_many :blog_posts

    def serializable_hash(options = nil)
        blog = super(options ||= {})
        
        blog[:type_name] = self.class.name.underscore
        
        if self.blog_posts.loaded?
            blog[:blog_posts] = self.blog_posts
        end
        
        if self.association(:user).loaded?
            blog[:user] = self.user
        end
        
        blog
    end
end
