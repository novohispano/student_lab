class Mentor
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActivityTracker

  field :name
  field :email
  field :phone
  field :github


  validates :name,  presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_and_belongs_to_many :students
  has_many :activities, dependent: :destroy
  has_many :mentor_reports, dependent: :destroy
end