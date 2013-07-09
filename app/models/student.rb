class Student
  include Mongoid::Document

  field :first_name
  field :last_name
  field :email
  field :phone
  field :github
end