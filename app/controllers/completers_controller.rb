class CompletersController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    redirect_to @project unless @project.finalised?

    @project.update!(status: "completed", completed_at: Date.today)
    redirect_to @project, notice: "Project successfully completed"
  end

end
