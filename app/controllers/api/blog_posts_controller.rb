class Api::BlogPostsController < ApiController
    respond_to :json

    def index
        blog_posts = BlogPost.all
        respond_with( blog_posts )
    end
  
    def show
        if params[:include]
            includes = includes_hash( params[:include] )
        else
            includes = {}
        end

        blog_post = BlogPost.includes(includes).find(params[:id])
        
        # TODO: this does not constitute an RBAC permissions system...
        blog_post[:permissions] = { :read => true, :write => blog_post.blog.user_id == session[:user_id] }
        
        respond_with( blog_post )
    end
    
    def update
        blog_post = BlogPost.find(params[:id])
        
        blog_post.tags.destroy_all
        blog_post.save
        
        if blog_post.update_attributes( BlogPost.deserialize_attributes( params[:data] ) )
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

        blog = Blog.find( params[:data][:blog_id] )
        blog_post = blog.blog_posts.create( BlogPost.deserialize_attributes( params[:data] ) )
        
        if blog_post.save
            respond_to do |format|
                format.json { render json: blog_post }
            end
        else
            logger.info "*** errors: #{blog_post.errors}"
        end
    end
end