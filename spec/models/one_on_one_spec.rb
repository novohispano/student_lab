require 'spec_helper'

describe Student do
  before :each do
    @student = Student.create(
      name: "Mr. Goat",
      email: "goat@example.com"
      )

    @user = User.create
  end

  def params
    {
      student_id: @student.id,
      one_on_one: 
      {
        user_id:  @user.id,
        description: "I love goats."
      },
    }
  end

  context "#create_one_on_one" do
    it "creates a one-on-one" do
      result = OneOnOne.new.create_one_on_one(params)

      expect(result).to be_valid
      expect(result.student_id).to eq @student.id
      expect(result.user_id).to eq @user.id
      expect(result.description).to eq "I love goats."
    end

    it "creates an activity" do
      one_on_one = OneOnOne.new.create_one_on_one(params)
      
      result = one_on_one.activities.last

      expect(result).not_to be_nil
      expect(result.one_on_one).to eq one_on_one
      expect(result.action).to eq "created"
    end
  end

  context "#update_one_on_one" do
    it "updates a one-on-one" do
      one_on_one  = OneOnOne.new.create_one_on_one(params)
      diff_params = { one_on_one: { description: "I love cows." } }
      
      result = one_on_one.update_one_on_one(diff_params)

      expect(result).to be_valid
      expect(result.student_id).to eq @student.id
      expect(result.user_id).to eq @user.id
      expect(result.description).to eq "I love cows."
    end

    it "creates an activity" do
      one_on_one  = OneOnOne.new.create_one_on_one(params)
      diff_params = { one_on_one: { description: "I love cows." } }
      one_on_one  = one_on_one.update_one_on_one(diff_params)
      
      result = one_on_one.activities.last

      expect(result).not_to be_nil
      expect(result.one_on_one).to eq one_on_one
      expect(result.action).to eq "updated"
    end
  end

  context "#destroy_one_on_one" do
    it "destroys a one-on-one" do
      one_on_one    = OneOnOne.new.create_one_on_one(params)
      one_on_one_id = one_on_one.id
      one_on_one.destroy_one_on_one(params)

      result = OneOnOne.find(one_on_one_id)

      expect(result).to be_nil
    end
  end
end