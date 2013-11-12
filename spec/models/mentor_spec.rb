require 'spec_helper'

describe Mentor do
  def params
    {
      name:   "Mr. Goat",
      email:  "goat@example.com",
      phone:  "1234567890",
      github: "http://github.com/novohispano"
    }
  end

  context "when given correct params" do
    context "#create_mentor" do
      it "creates a mentor" do
        result = Mentor.new.create_mentor(params)

        expect(result).to be_valid
        expect(result.class).to eq Mentor
        expect(result.name).to eq "Mr. Goat"
        expect(result.email).to eq "goat@example.com"
        expect(result.phone).to eq "1234567890"
        expect(result.github).to eq "http://github.com/novohispano"
      end

      it "creates a mentor with an activity" do
        mentor = Mentor.new.create_mentor(params)

        result = mentor.activities.last

        expect(result).not_to be_nil
        expect(result.mentor_id).to eq mentor.id
        expect(result.action).to eq "added"
      end
    end

    context "#update_mentor" do
      def diff_params
        {
          mentor:
          {
            name:   "Mr. Cow",
            email:  "cow@example.com",
            phone:  "9876543210",
            github: "http://github.com/mu"
          }
        }
      end

      it "updates a mentor" do
        mentor = Mentor.new.create_mentor(params)

        result = mentor.update_mentor(diff_params)

        expect(result).to be_valid
        expect(result.name).to eq "Mr. Cow"
        expect(result.email).to eq "cow@example.com"
        expect(result.phone).to eq "9876543210"
        expect(result.github).to eq "http://github.com/mu"
      end

      it "updates a mentor with an activity" do
        mentor = Mentor.new.create_mentor(params)
        mentor.update_mentor(diff_params)

        result = mentor.activities.last

        expect(result).not_to be_nil
        expect(result.mentor_id).to eq mentor.id
        expect(result.action).to eq "updated"
      end
    end

    context "#destroy_mentor" do
      it "destroys a mentor" do
        mentor    = Mentor.new.create_mentor(params)
        mentor_id = mentor.id
        mentor.destroy_mentor(params)

        result = Mentor.find(mentor_id)

        expect(result).to be_nil
      end
    end
  end

  context "when given incorrect params" do
    it "doesn't create a mentor when name doesn't exist" do
      invalid_params        = params
      invalid_params[:name] = nil

      result = Mentor.new.create_mentor(invalid_params)

      expect(result).not_to be_valid
    end

    it "doesn't create a mentor when email doesn't exist" do
      invalid_params         = params
      invalid_params[:email] = nil

      result = Mentor.new.create_mentor(invalid_params)

      expect(result).not_to be_valid
    end
  end

  context "when the mentor already exists" do
    it "doesn't create a mentor when the name already exists" do
      Mentor.new.create_mentor(params)

      different_params         = params
      different_params[:email] = "farm@example.com"

      result = Mentor.new.create_mentor(different_params)

      expect(result).not_to be_valid
    end

    it "doesn't create a mentor when the email already exists" do
      Mentor.new.create_mentor(params)

      different_params        = params
      different_params[:name] = "John Goat"

      result = Mentor.new.create_mentor(different_params)

      expect(result).not_to be_valid
    end
  end
end