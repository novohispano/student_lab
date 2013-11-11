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

  has_and_belongs_to_many :mentors
  has_many :mentor_reports

  def create_student(params)
    student = Student.create(
      name:   params[:name],
      email:  params[:email],
      phone:  params[:phone],
      github: params[:github]
      )

    student.create_activity("added", params) if student.save

    student
  end

  def update_student(params)
    params = params[:student]

    self.update_attributes(
      name:   params[:name],
      email:  params[:email],
      phone:  clean_phone(params[:phone]),
      github: params[:github]
      )

    self.create_activity("updated", params) if self.save

    self
  end

  def destroy_student(params)
    self.create_activity("deleted", params)

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

  private

  def clean_phone(number)
    number.gsub(/\D/, "")[0..10]
  end
end