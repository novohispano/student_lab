class Student
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email
  field :phone
  field :github

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :activities
  has_many :one_on_ones

  def self.create_student(params)
    student = Student.create(
      name:   params[:name],
      email:  params[:email],
      phone:  params[:phone],
      github: params[:github]
      )

    Activity.create(
      student_id: student.id,
      user_id:    params[:user_id],
      action:     "added student"
      )

    student
  end
end