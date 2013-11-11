class MentorReport
  include Mongoid::Document

  belongs_to :mentor
  belongs_to :student
end