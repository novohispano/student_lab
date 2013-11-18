class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action

  validates :action, presence: true

  belongs_to :user
  belongs_to :student
  belongs_to :one_on_one
  belongs_to :mentor
  belongs_to :mentor_report
end