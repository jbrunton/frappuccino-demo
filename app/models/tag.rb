class Tag < ActiveRecord::Base
    belongs_to :blog_post
    
    attr_accessible :tag
end
