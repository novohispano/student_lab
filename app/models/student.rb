class Student
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email
  field :phone
  field :github

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.create_student(params)
    student = Student.create

    student.name   = params[:name]
    student.email  = params[:email]
    student.phone  = params[:phone]
    student.github = params[:github]

    student.save
    student
  end
end