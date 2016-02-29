module Features
  def go_to_project_page(project)
    click_on "Projects"
    click_on "project_#{ project.id }"
  end
end
