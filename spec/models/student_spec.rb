require 'spec_helper'

describe Student do
  def params
    {
      name:   "Mr. Goat",
      email:  "goat@example.com",
      phone:  "12345679",
      github: "http://github.com/novohispano"
    }
  end

  context "when given correct params" do
    it "creates a student" do
      result = Student.new.create_student(params)

      expect(result).to be_valid
      expect(result.class).to eq Student
      expect(result.name).to eq "Mr. Goat"
      expect(result.email).to eq "goat@example.com"
      expect(result.phone).to eq "12345679"
      expect(result.github).to eq "http://github.com/novohispano"
    end
  end

  context "when given incorrect params" do
    it "doesn't create a student when name doesn't exist" do
      invalid_params        = params
      invalid_params[:name] = nil

      result = Student.new.create_student(invalid_params)

      expect(result).not_to be_valid
    end

    it "doesn't create a student when email doesn't exist" do
      invalid_params        = params
      invalid_params[:email] = nil

      result = Student.new.create_student(invalid_params)

      expect(result).not_to be_valid
    end
  end

  context "when the student already exists" do
    it "doesn't create a student when the name already exists" do
      Student.new.create_student(params)
      
      different_params = params
      different_params[:email] = "farm@example.com"

      result = Student.new.create_student(different_params)

      expect(result).not_to be_valid
    end

    it "doesn't create a student when the email already exists" do
      Student.new.create_student(params)
      
      different_params = params
      different_params[:name] = "John Goat"

      result = Student.new.create_student(different_params)

      expect(result).not_to be_valid
    end
  end
end