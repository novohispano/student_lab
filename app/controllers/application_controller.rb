class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :students, :mentors

  private

  helper_method :current_user,
                :authenticate_user,
                :authorized_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorized_user
    current_user && current_user.admin?
  end

  def authenticate_user
    unless authorized_user
      redirect_to root_path, alert: "You are not authorized to login. Please contact Jumpstart Lab."
    end
  end

  def students
    @students ||= Student.all.asc(:name)
  end

  def mentors
    @mentors ||= Mentor.all.asc(:name)
  end
end