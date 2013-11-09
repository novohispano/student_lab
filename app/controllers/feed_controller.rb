class FeedController < ApplicationController
  before_action :authenticate_user

  def show
    @activities = Activity.all.desc(:created_at).page(params[:page])
  end
end