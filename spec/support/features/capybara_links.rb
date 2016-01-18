module Features
  def click_link_by_href(href)
    find(:xpath, "//a[@href='#{ href }']").click
  end
end
