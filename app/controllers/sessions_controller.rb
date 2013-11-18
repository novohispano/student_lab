class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.admin?
      redirect_to students_path
    else
      redirect_to root_path, alert: "You are not authorized to login. Please contact Jumpstart Lab."
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end