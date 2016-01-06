module ApplicationHelper
  def format_area(area)
    "#{ area }m<sup>2</sup>".html_safe
  end
end
