class StudentsController < ApplicationController
  before_action :authenticate_user

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @students = Student.all
    @student  = Student.new
  end

  def create
    student = Student.create_student(params[:student])

    if student.save
      redirect_to feed_path, notice: "#{student.name} was added to Student Lab."
    else
      redirect_to new_student_path, alert: "There was a problem adding a student. Please try again."
    end
  end
end