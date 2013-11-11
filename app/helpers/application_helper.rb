module ApplicationHelper
  def format_time(input)
    input.localtime.strftime("%B %d, %Y - %l:%M %p")
  end

  def description(activity)
    case
    when activity.one_on_one
      build_one_on_one(activity)
    when activity.student
      build_student(activity)
    when activity.mentor
      build_mentor(activity)
    end
  end

  def format_phone(input)
    "#{input[0..2]}.#{input[3..5]}.#{input[5..8]}"
  end

  private

  def build_one_on_one(activity)
    student     = activity.student
    student_url = link_to student.name, student_path(student.id)

    if activity.action == "deleted"
      "<b>#{activity.user.name}</b> deleted a session for student <b>#{student_url}</b>.".html_safe
    else
      activity_url = link_to "one-on-one session", student_one_on_one_path(student.id, activity.one_on_one.id)
      "<b>#{activity.user.name}</b> #{activity.action} a #{activity_url} for student <b>#{student_url}</b>.".html_safe
    end
  end

  def build_student(activity)
    student     = activity.student
    student_url = link_to student.name, student_path(student.id)

    case activity.action
    when "added"
      "<b>#{activity.user.name}</b> #{activity.action} student <b>#{student_url}</b> to StudentLab.".html_safe
    when "deleted"
      "<b>#{activity.user.name}</b> #{activity.action} a student".html_safe
    when "updated"
      "<b>#{activity.user.name}</b> #{activity.action} student <b>#{student_url}</b>'s profile.".html_safe
    end
  end

  def build_mentor(activity)
    mentor     = activity.mentor
    mentor_url = link_to mentor.name, mentor_path(mentor.id)

    case activity.action
    when "added"
      "<b>#{activity.user.name}</b> #{activity.action} mentor <b>#{mentor_url}</b> to StudentLab.".html_safe
    when "deleted"
      "<b>#{activity.user.name}</b> #{activity.action} a mentor".html_safe
    when "updated"
      "<b>#{activity.user.name}</b> #{activity.action} mentor <b>#{mentor_url}</b>'s profile.".html_safe
    end
  end
end