require 'spec_helper'

describe Student do
  def params
    {
      name:   "Mr. Goat",
      email:  "goat@example.com",
      phone:  "1234567890",
      github: "http://github.com/novohispano"
    }
  end

  context "when given correct params" do
    context "#create_student" do
      it "creates a student" do
        result = Student.new.create_student(params)

        expect(result).to be_valid
        expect(result.class).to eq Student
        expect(result.name).to eq "Mr. Goat"
        expect(result.email).to eq "goat@example.com"
        expect(result.phone).to eq "1234567890"
        expect(result.github).to eq "http://github.com/novohispano"
      end

      it "creates a student with an activity" do
        student = Student.new.create_student(params)

        result = student.activities.last

        expect(result).not_to be_nil
        expect(result.student_id).to eq student.id
        expect(result.action).to eq "added"
      end
    end

    context "#update_student" do
      def diff_params
        {
          student:
          {
            name:   "Mr. Cow",
            email:  "cow@example.com",
            phone:  "9876543210",
            github: "http://github.com/mu"
          }
        }
      end

      it "updates a student" do
        student = Student.new.create_student(params)

        result = student.update_student(diff_params)

        expect(result).to be_valid
        expect(result.name).to eq "Mr. Cow"
        expect(result.email).to eq "cow@example.com"
        expect(result.phone).to eq "9876543210"
        expect(result.github).to eq "http://github.com/mu"
      end

      it "updates a student with an activity" do
        student = Student.new.create_student(params)
        student.update_student(diff_params)

        result = student.activities.last

        expect(result).not_to be_nil
        expect(result.student_id).to eq student.id
        expect(result.action).to eq "updated"
      end
    end

    context "#destroy_student" do
      it "destroys a student" do
        student    = Student.new.create_student(params)
        student_id = student.id
        student.destroy_student(params)

        result = Student.find(student_id)

        expect(result).to be_nil
      end
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
      invalid_params         = params
      invalid_params[:email] = nil

      result = Student.new.create_student(invalid_params)

      expect(result).not_to be_valid
    end
  end

  context "when the student already exists" do
    it "doesn't create a student when the name already exists" do
      Student.new.create_student(params)

      different_params         = params
      different_params[:email] = "farm@example.com"

      result = Student.new.create_student(different_params)

      expect(result).not_to be_valid
    end

    it "doesn't create a student when the email already exists" do
      Student.new.create_student(params)

      different_params        = params
      different_params[:name] = "John Goat"

      result = Student.new.create_student(different_params)

      expect(result).not_to be_valid
    end
  end
end