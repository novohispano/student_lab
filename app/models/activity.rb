class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action

  belongs_to :user
  belongs_to :student
  belongs_to :one_on_one
end