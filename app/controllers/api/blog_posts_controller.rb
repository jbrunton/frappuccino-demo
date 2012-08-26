class Api::BlogPostsController < ApiController
    respond_to :json

    def index
        blog_posts = BlogPost.all
        respond_with( blog_posts )
    end
  
    def show
        if params[:includes]
            includes = includes_hash( params[:includes] )
        else
            includes = {}
        end

        blog_post = BlogPost.includes(includes).find(params[:id])
        respond_with( blog_post )
    end
    
    def update
        blog_post = BlogPost.find(params[:id])
        
        blog_post.tags.destroy_all
        blog_post.save
        
        if params[:data][:tags_attributes]
            params[:data][:tags_attributes] = params[:data][:tags_attributes].collect{ |tag| { :tag => tag } }
        end
        
        logger.info "*** params[:data]: #{params[:data]}"
        
        if blog_post.update_attributes(params[:data])
            respond_to do |format|
                format.json { render json: blog_post }
            end
        else
            logger.info "*** errors: #{blog_post.errors}"
            # how to respond?
        end
    end
    
    def create
        logger.info "*** params: #{params.to_yaml}"
        
        if params[:data][:tags]
            params[:data][:tags] = params[:data][:tags].collect{ |tag| Tag.new(:tag => tag ) }
        end
        
        blog_post = BlogPost.new(params[:data])
        
        if blog_post.save
            respond_to do |format|
                format.json { render json: blog_post }
            end
        else
            logger.info "*** errors: #{blog_post.errors}"
        end
    end
end