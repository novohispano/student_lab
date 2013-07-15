module ApplicationHelper
  def format_time(input)
    input.localtime.strftime("%B %d, %Y - %l:%M %p")
  end

  def description(activity)
    user_name     = activity.user.name
    student       = activity.student
    student_url   = link_to student.name, student_path(student.id)
    one_on_one    = activity.one_on_one

    if activity.action != "deleted"
      one_on_one_url = link_to "one-on-one session", student_one_on_one_path(student.id, one_on_one.id)
      "<b>#{user_name}</b> #{activity.action} a #{one_on_one_url} for student <b>#{student_url}</b>.".html_safe
    else
      "<b>#{user_name}</b> deleted a session for student <b>#{student_url}</b>.".html_safe
    end
  end
end