class StudentsController < ApplicationController
  before_action :authenticate_user

  def show
    @student    = Student.find(params[:id])
    @activities = @student.activities.desc(:created_at).page(params[:page])
  end

  def new
    @student = Student.new
  end

  def create
    student = Student.new.create_student(params[:student])

    if student.save
      redirect_to feed_path, notice: "#{student.name} was added to StudentLab."
    else
      redirect_to new_student_path, alert: "There was a problem adding a student. Please try again."
    end
  end

  def edit
    @student    = Student.find(params[:id])
    @activities = @student.activities.desc(:created_at).page(params[:page])
  end

  def update
    student     = Student.find(params[:id])
    @activities = student.activities.desc(:created_at).page(params[:page])

    student.update_student(params)

    if student.save
      redirect_to student_path(student.id), notice: "#{student.name}'s profile was updated."
    else
      redirect_to edit_student_path(student.id), alert: "There was a problem updating #{student.name}'s profile. Please try again."
    end
  end

  def destroy
    student = Student.find(params[:id])
    name    = student.name

    student.destroy_student(params)

    redirect_to feed_path, notice: "#{name} was removed from StudentLab."
  end
end