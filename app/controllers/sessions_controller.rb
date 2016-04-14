class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    unless auth["info"]["email"].match(/generalassemb\.ly/)
      flash[:notice] = "Must login with a ga email address"
      return redirect_to root_url
    end
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end