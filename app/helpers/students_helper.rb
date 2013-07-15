module StudentsHelper
  def format_description(description)
    description.gsub(" for student", "")
  end
end