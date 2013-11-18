class MentorReportsController < ApplicationController
  before_action :authenticate_user,
                :mentor

  def index
    @mentor_reports = @mentor.mentor_reports.desc(:created_at)
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
      redirect_to mentor_report_path(id: mentor_report, mentor_id: @mentor.id), notice: "A new report was created for mentor #{@mentor.name}."
    else
      redirect_to new_mentor_report_path, alert: "There was a problem creating the mentor report. Please try again."
    end
  end

  def edit
    @mentor_report = MentorReport.find(params[:id])
  end

  def update
    mentor_report = MentorReport.find(params[:id])
    mentor_report.update_mentor_report(mentor_report_params)

    if mentor_report.save
      redirect_to mentor_report_path(id: mentor_report, mentor_id: @mentor.id), notice: "The report for mentor #{@mentor.name} was updated."
    else
      redirect_to edit_mentor_report_path(id: mentor_report, mentor_id: @mentor.id), alert: "There was a problem updating the mentor report. Please try again."
    end
  end

  def destroy
    mentor_report = MentorReport.find(params[:id])
    mentor_report.destroy_mentor_report(params)

    redirect_to mentor_reports_path(mentor_id: @mentor.id), notice: "The report for mentor #{@mentor.name} was deleted."
  end

  private

  def mentor
    @mentor = Mentor.find(params[:mentor_id])
  end

  def mentor_report_params
    mentor_report               = params.slice(:mentor_id, :user_id)
    mentor_report[:description] = params[:mentor_report][:description]
    mentor_report[:student_id]  = params[:mentor_report][:student_id]
    mentor_report.permit(:student_id, :mentor_id, :description, :user_id)
  end
end