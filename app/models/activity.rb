class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description

  belongs_to :user
  belongs_to :student
end