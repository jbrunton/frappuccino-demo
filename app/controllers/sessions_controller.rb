class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      user = @authorization.user
    else
      user = User.new :screen_name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
    end
    
    cookies[:screen_name] = user.screen_name
    cookies[:user_id] = user.id
    
    redirect_to "/#"
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
  
  def destroy
    session[:user_id] = nil
    cookies.delete :screen_name
    cookies.delete :user_id
    redirect_to root_path
  end
end
