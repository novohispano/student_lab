class HomeController < ApplicationController
  def show
    redirect_to feed_path if authorized_user
  end
end