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

    if one_on_one.save
      action = "created"
      one_on_one.create_activity(action, params)
    end

    one_on_one
  end

  def update_one_on_one(params)
    self.update_attributes(
      description: format_description(params[:one_on_one][:description])
      )

    if self.save
      action = "updated"
      self.create_activity(action, params)
    end

    self
  end

  def destroy_one_on_one(params)
    action = "deleted"
    self.create_activity(action, params)

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