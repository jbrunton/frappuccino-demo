class User < ActiveRecord::Base
    attr_accessible :screen_name, :email, :bio, :avatar_url
      
    has_many :blogs
    has_many :recent_posts, :through => :blogs, :source => :blog_posts
    
    has_many :authorizations
    validates :screen_name, :email, :presence => true

    def serializable_hash(options = nil)
        user = super(options ||= {})
        
        user[:type_name] = self.class.name.underscore
        
        if self.blogs.loaded?
            user[:blogs] = self.blogs
        end
        
        if self.recent_posts.loaded?
            user[:recent_posts] = self.recent_posts
        end
        
        # user[:recent_posts] = BlogPost.where(:blog_id => user.blog_id)
        
        user
    end
end
