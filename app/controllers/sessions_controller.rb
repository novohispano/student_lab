class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to feed_path
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end