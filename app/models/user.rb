class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email
  field :image
  field :provider
  field :uid
  field :oauth_token

  has_many :activities
  has_many :one_on_ones

  def self.from_omniauth(params)
    find_user(params) || create_user(params)
  end

  def self.find_user(params)
    User.find_by(
      provider: params.provider,
      uid:      params.uid,
      )
  end

  def self.create_user(params)
    user = User.new

    user.provider    = params.provider,
    user.uid         = params.uid,
    user.name        = params.info.name
    user.email       = params.info.email
    user.image       = params.info.image
    user.oauth_token = params.credentials.token

    user.save
    user
  end
end