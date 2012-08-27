class Api::UsersController < ApiController
    respond_to :json

    def index
        users = User.all
        respond_with( users )
    end
    
    def show
        if params[:include]
            includes = includes_hash( params[:include] )
        else
            includes = {}
        end

        user = User.includes(includes).find(params[:id])
        
        # TODO: this does not constitute an RBAC permissions system...
        user[:permissions] = { :read => true, :write => user.id == session[:user_id] }
        
        respond_with( user )
    end
    
    def update
        user = User.find(params[:id])
        
        if user.update_attributes(params[:data])
            respond_to do |format|
                format.json { render json: user }
            end
        else
            logger.info "*** errors: #{object.errors}"
            # how to respond?
        end
    end
    
    def create
        user = User.new(params[:data])
        
        if user.save
            respond_to do |format|
                format.json { render json: user }
            end
        else
            logger.info "*** errors: #{object.errors}"
        end
    end

end