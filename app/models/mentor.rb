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

  def update_mentor(params)
    params = params[:mentor]

    self.update_attributes(
      name:   params[:name],
      email:  params[:email],
      phone:  clean_phone(params[:phone]),
      github: params[:github]
      )

    self.create_activity("updated", params) if self.save

    self
  end

  def destroy_mentor(params)
    self.create_activity("deleted", params)

    self.destroy
  end

  def create_activity(action, params)
    activity = Activity.create(
      mentor_id: self.id,
      user_id:   params[:user_id],
      action:    action
      )

    activity.save
  end

  private

  def clean_phone(number)
    number.gsub(/\D/, "")[0..10]
  end
end