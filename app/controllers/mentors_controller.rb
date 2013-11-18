class MentorsController < ApplicationController
  before_action :authenticate_user

  def index
    @activities = Activity.all.desc(:created_at).page(params[:page])
  end

  def show
    @mentor     = Mentor.find(params[:id])
    @activities = @mentor.activities.desc(:created_at).page(params[:page])
  end

  def new
    @mentor = Mentor.new
  end

  def create
    mentor = Mentor.new.create_mentor(params[:mentor])

    if mentor.save
      redirect_to mentors_path, notice: "#{mentor.name} was added to StudentLab."
    else
      redirect_to new_mentor_path, alert: "There was a problem adding a mentor. Please try again."
    end
  end

  def edit
    @mentor    = Mentor.find(params[:id])
    @activities = @mentor.activities.desc(:created_at).page(params[:page])
  end

  def update
    mentor      = Mentor.find(params[:id])
    @activities = mentor.activities.desc(:created_at).page(params[:page])

    mentor.update_mentor(params)

    if mentor.save
      redirect_to mentor_path(mentor.id), notice: "#{mentor.name}'s profile was updated."
    else
      redirect_to edit_mentor_path(mentor.id), alert: "There was a problem updating #{mentor.name}'s profile. Please try again."
    end
  end

  def destroy
    mentor  = Mentor.find(params[:id])
    name    = mentor.name

    mentor.destroy_mentor(params)

    redirect_to mentors_path, notice: "#{name} was removed from StudentLab."
  end
end