class OneOnOne
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description

  belongs_to :student
  belongs_to :user
  has_many   :activities, dependent: :destroy

  def create_one_on_one(params)
    one_on_one = OneOnOne.create(
      student_id:  params[:student_id],
      user_id:     params[:one_on_one][:user_id],
      description: format_description(params[:one_on_one][:description])
      )

    one_on_one.create_activity("created", params) if one_on_one.save

    one_on_one
  end

  def update_one_on_one(params)
    self.update_attributes(
      description: format_description(params[:one_on_one][:description])
      )

    self.create_activity("updated", params) if self.save

    self
  end

  def destroy_one_on_one(params)
    self.create_activity("deleted", params)

    self.destroy
  end

  def create_activity(action, params)
    activity = Activity.create(
      student_id:    params[:student_id],
      user_id:       params[:one_on_one][:user_id],
      one_on_one_id: self.id,
      action:        action
      )

    activity.save
  end

  private

  def format_description(description)
    description.gsub("\n", "<br>").html_safe
  end
end