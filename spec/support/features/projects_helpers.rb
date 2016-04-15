module Features
  def go_to_project_page(project)
    visit projects_path
    click_link "project_#{ project.id }"
  end
end
