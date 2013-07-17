class Student
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email
  field :phone
  field :github

  validates :name,  presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :one_on_ones
  has_many :activities, dependent: :destroy

  def create_student(params)
    student = Student.create(
      name:   params[:name],
      email:  params[:email],
      phone:  params[:phone],
      github: params[:github]
      )

    action = "added"
    student.create_activity(action, params)

    student
  end

  def update_student(params)
    params = params[:student]

    self.update_attributes(
      name:   params[:name],
      email:  params[:email],
      phone:  params[:phone],
      github: params[:github]
      )

    action = "updated"
    self.create_activity(action, params)

    self
  end

  def destroy_student(params)
    action = "deleted"
    self.create_activity(action, params)

    self.destroy
  end

  def create_activity(action, params)
    activity = Activity.create(
      student_id: self.id,
      user_id:    params[:user_id],
      action:     action
      )

    activity.save
  end
end