class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      user = @authorization.user
    else
      # TODO: unsuitable for production, but makes it easier to match up facebook auths with seed data
      user = User.where(:email => auth_hash["info"]["email"]).first
      user = create_user_from_hash(auth_hash) unless user
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
    end
    
    session[:user_id] = user.id
    cookies[:user_id] = user.id
    cookies[:screen_name] = user.screen_name
    
    redirect_to "/"
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
  
  def destroy
    session[:user_id] = nil
    cookies.delete :screen_name
    cookies.delete :user_id
    redirect_to "/"
  end
  
  private
  def create_user_from_hash(auth_hash)
    User.new :screen_name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
  end
end
