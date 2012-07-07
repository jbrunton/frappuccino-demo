class Api::BlogsController < ApiController
    respond_to :json

    def index
        blogs = Blog.all
        respond_with( blogs )
    end
  
    def show
        blog = Blog.find(params[:id])
        respond_with( blog )
    end
    
    def update
        blog = Blog.find(params[:id])
        
        if blog.update_attributes(params[:data])
            respond_to do |format|
                format.json { render json: blog }
            end
        else
            logger.info "*** errors: #{object.errors}"
            # how to respond?
        end
    end
    
    def create
        blog = Blog.new(params[:data])
        
        if blog.save
            respond_to do |format|
                format.json { render json: blog }
            end
        else
            logger.info "*** errors: #{object.errors}"
        end
    end
end