class MentorsController < ApplicationController
  before_action :authenticate_user

  def index
    @activities = Activity.all.desc(:created_at).page(params[:page])
  end

  def new
    @mentor = Mentor.new
  end

  def create
    mentor = Mentor.new.create_mentor(params[:mentor])

    if mentor.save
      redirect_to mentor_path, notice: "#{mentor.name} was added to StudentLab."
    else
      redirect_to new_mentor_path, alert: "There was a problem adding a mentor. Please try again."
    end
  end
end