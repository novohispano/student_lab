require 'spec_helper'

describe Activity do
  context "when given valid params" do
    attr_accessor :activity

    before :each do
      @activity = Activity.create(action: "added")
    end

    it "creates an activity" do
      result = activity
      expect(result).to be_valid
    end

    it "has a user" do
      user = User.create
      activity.user = user
      result = activity

      expect(activity.user).not_to be_nil
      expect(activity.user).to eq user
    end

    it "has a student" do
      student = Student.create
      activity.student = student
      result = activity

      expect(activity.student).not_to be_nil
      expect(activity.student).to eq student
    end

    it "has a one_on_one" do
      one_on_one = OneOnOne.create
      activity.one_on_one = one_on_one
      result = activity

      expect(activity.one_on_one).not_to be_nil
      expect(activity.one_on_one).to eq one_on_one
    end

    it "has a mentor" do
      mentor = Mentor.create
      activity.mentor = mentor
      result = activity

      expect(activity.mentor).not_to be_nil
      expect(activity.mentor).to eq mentor
    end
  end

  context "when given valid params" do
    it "does not create an activity without an action" do
      result = Activity.create

      expect(result).not_to be_valid
    end
  end
end