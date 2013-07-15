module OneOnOnesHelper
  def breaks_to_line_breaks(description)
    description.gsub("<br>", "\n")
  end
end