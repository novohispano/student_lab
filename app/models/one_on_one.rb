class OneOnOne
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description

  belongs_to :student
  belongs_to :user

  def self.create_one_on_one(params)
    one_on_one = OneOnOne.create(
      student_id:  params[:student_id],
      user_id:     params[:one_on_one][:user_id],
      description: params[:one_on_one][:description]
      )

    Activity.create(
      student_id:  params[:student_id],
      user_id:     params[:one_on_one][:user_id],
      description: "created a one-on-one session for student"
      )

    one_on_one
  end

  def update_one_on_one(params)
    self.description = params[:one_on_one][:description]
    self.save

    Activity.create(
      student_id:  params[:student_id],
      user_id:     params[:one_on_one][:user_id],
      description: "updated a one-on-one session for student"
      )

    self
  end
end