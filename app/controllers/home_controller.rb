class HomeController < ApplicationController
  def show
    redirect_to students_path if authorized_user
  end
end