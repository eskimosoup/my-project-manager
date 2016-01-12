module ApplicationHelper
  def format_area(area)
    "#{ area }m<sup>2</sup>".html_safe
  end
  
  def octicon(code)
    content_tag :span, '', class: "octicon octicon-#{code.to_s.dasherize}"
  end
end
