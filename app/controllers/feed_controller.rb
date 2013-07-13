class FeedController < ApplicationController
  before_action :authenticate_user

  def show
    @activities = Activity.all
  end
end