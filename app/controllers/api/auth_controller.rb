class Api::AuthController < ApiController
    respond_to :json

    def index
        users = User.where(:email => params[:email])
        
        if (users.length)
            respond_with( users[0] )
        end
    end
end