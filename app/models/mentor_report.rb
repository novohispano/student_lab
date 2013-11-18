class MentorReport
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description

  belongs_to :mentor
  belongs_to :student
  has_many   :activities, dependent: :destroy

  def create_mentor_report(params)
    mentor_report = MentorReport.create(
      student_id:  params[:student_id],
      user_id:     params[:mentor_report][:user_id],
      description: format_description(params[:mentor_report][:description])
      )

    mentor_report.create_activity("created", params) if mentor_report.save

    mentor_report
  end

  def update_mentor_report(params)
    self.update_attributes(
      description: format_description(params[:mentor_report][:description])
      )

    self.create_activity("updated", params) if self.save

    self
  end

  def destroy_mentor_report(params)
    self.create_activity("deleted", params)

    self.destroy
  end

  def create_activity(action, params)
    activity = Activity.create(
      student_id:    params[:student_id],
      user_id:       params[:mentor_report][:user_id],
      mentor_report_id: self.id,
      action:        action
      )

    activity.save
  end

  private

  def format_description(description)
    description.gsub("\n", "<br>").html_safe
  end
end