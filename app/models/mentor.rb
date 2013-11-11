class Mentor
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email
  field :phone
  field :github


  validates :name,  presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_and_belongs_to_many :students
  has_many :activities, dependent: :destroy
  has_many :mentor_reports, dependent: :destroy

  def create_mentor(params)
    mentor = Mentor.create(
      name:   params[:name],
      email:  params[:email],
      phone:  params[:phone],
      github: params[:github]
      )

    mentor.create_activity("added", params) if mentor.save

    mentor
  end

  def create_activity(action, params)
    activity = Activity.create(
      mentor_id: self.id,
      user_id:   params[:user_id],
      action:    action
      )

    activity.save
  end
end