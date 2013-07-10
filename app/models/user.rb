class User
  include Mongoid::Document

  field name:
  field provider:
  field uid:
  field oauth_token:
  field oauth_expires_at:
end