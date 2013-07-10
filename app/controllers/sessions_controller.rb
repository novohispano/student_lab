class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(params_processor(params))
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
  end

  private

  def params_processor(params)
    params.slice(:provider, :uid)
  end
end