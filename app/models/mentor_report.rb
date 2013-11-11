class MentorReport
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :mentor
  belongs_to :student
end