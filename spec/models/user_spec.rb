require 'spec_helper'

describe User do
  def params
    params = OpenStruct.new

    params.uid = "123456"

    params.info       = OpenStruct.new
    params.info.name  = "Mr. Goat"
    params.info.email = "goat@example.com"
    params.info.image = "http://example.com"

    params.credentials       = OpenStruct.new
    params.credentials.token = "secret_token"

    params
  end

  it "finds or creates user when the user exists" do
    result = User.from_omniauth(params)

    expect(result.class).to be User
    expect(result).to be_valid
  end

  it "creates a user" do
    result = User.create_user(params)

    expect(result.class).to be User
    expect(result).to be_valid
    expect(result.uid).to eq "123456"
    expect(result.name).to eq "Mr. Goat"
    expect(result.email).to eq "goat@example.com"
    expect(result.image).to eq "http://example.com"
    expect(result.oauth_token).to eq "secret_token"
  end

  it "finds a user when user already exists" do
    User.create_user(params)
    original_count = User.all.count

    User.from_omniauth(params)
    new_count = User.all.count

    expect(original_count).to eq new_count
  end
end