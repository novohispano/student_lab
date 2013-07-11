class FeedController < ApplicationController
  before_action :authenticate_user

  def show
    @students = Student.all
  end
end