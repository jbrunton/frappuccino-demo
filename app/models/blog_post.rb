class BlogPost < ActiveRecord::Base
    belongs_to :blog
    has_many :tags
    
    attr_accessible :title, :leader, :content, :tags, :created_at, :tags_attributes
    
    accepts_nested_attributes_for :tags
    
    def serializable_hash(options = nil)
        blog_post = super(options ||= {})
        
        blog_post[:type_name] = self.class.name.underscore
        
        if !self.tags.nil?
            blog_post[:tags] = self.tags.collect{ |tag| tag.tag }
        end
        
        if self.association(:blog).loaded?
            blog_post[:blog] = self.blog
        end
        
        blog_post
    end
    
    def self.deserialize_attributes( data )
        attributes = data.clone
        attributes.delete(:blog_id)
        
        if data[:tags_attributes]
            tags = data[:tags_attributes].collect{ |tag| { :tag => tag } }
            logger.info "*** tags: #{tags.inspect}"
            attributes.merge!( :tags_attributes => tags )
        end
        
        attributes
    end
    
    def self.deserialize( data )
        BlogPost.new( deserialize_attributes( data ) )
    end
end
