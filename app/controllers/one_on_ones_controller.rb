class OneOnOnesController < ApplicationController
  before_action :student

  def index
    @one_on_ones = @student.one_on_ones
  end

  def show
    @one_on_one = OneOnOne.find(params[:id])
  end

  def new
    @one_on_one = OneOnOne.new
  end

  def create
    one_on_one = OneOnOne.create_one_on_one(params)

    if one_on_one.save
      redirect_to student_one_on_ones_path(@student.id), notice: "A new one on one session was created for student #{@student.name}."
    else
      redirect_to new_student_one_on_one_path, alert: "There was a problem creating your one-on-one session. Please try again."
    end
  end

  def edit
    @one_on_one = OneOnOne.find(params[:id])
  end

  def update
    one_on_one = OneOnOne.find(params[:id])
    one_on_one.update_one_on_one(params)

    if one_on_one.save
      redirect_to student_one_on_one_path(@student.id, one_on_one.id), notice: "The session for student #{@student.name} was updated."
    else
      redirect_to new_student_one_on_one_path, alert: "There was a problem updating your session. Please try again."
    end
  end

  def destroy
    one_on_one = OneOnOne.find(params[:id])
    one_on_one.destroy_one_on_one(params)

    redirect_to student_one_on_ones_path(@student.id), notice: "The session for student #{@student.name} was deleted."
  end

  private

  def student
    @student = Student.find(params[:student_id])
  end
end