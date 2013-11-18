class StudentMentorReportsController < ApplicationController
  before_action :authenticate_user,
                :student

  def index
    @mentor_reports = @student.mentor_reports.desc(:created_at)
  end

  def show
    @mentor_report = MentorReport.find(params[:id])
  end

  def new
    @mentor_report = MentorReport.new
  end

  def create
    mentor_report = MentorReport.new.create_mentor_report(mentor_report_params)

    if mentor_report.save
      redirect_to student_mentor_report_path(@student.id, mentor_report.id), notice: "A new mentor report was created for student #{@student.name}."
    else
      redirect_to new_student_mentor_report_path, alert: "There was a problem creating your mentor report. Please try again."
    end
  end

  def edit
    @mentor_report = MentorReport.find(params[:id])
  end

  def update
    mentor_report = MentorReport.find(params[:id])
    mentor_report.update_mentor_report(mentor_report_params)

    if mentor_report.save
      redirect_to student_mentor_report_path(@student.id, mentor_report.id), notice: "The mentor report for student #{@student.name} was updated."
    else
      redirect_to edit_student_mentor_report_path(@student.id, mentor_report.id), alert: "There was a problem updating the mentor report. Please try again."
    end
  end

  def destroy
    mentor_report = MentorReport.find(params[:id])
    mentor_report.destroy_mentor_report(params)

    redirect_to student_mentor_reports_path(@student.id), notice: "The mentor report for student #{@student.name} was deleted."
  end

  private

  def student
    @student = Student.find(params[:student_id])
  end

  def mentor_report_params
    mentor_report               = params.slice(:student_id, :user_id)
    mentor_report[:mentor_id]   = params[:mentor_report][:mentor_id]
    mentor_report[:description] = params[:mentor_report][:description]
    mentor_report.permit(:student_id, :mentor_id, :description, :user_id)
  end
end