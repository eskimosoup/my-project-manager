class ProjectFinalisersController < ApplicationController
  before_action :set_project

  def new
    @finalised_status_changer = StatusChanger::Finalised.new(@project)
  end

  def create
    @finalised_status_changer = StatusChanger::Finalised.new(@project, status_changer_finalised_params)
    if @finalised_status_changer.save
      redirect_to @project, notice: "Project successfully finalised"
    else
      render :new
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def status_changer_finalised_params
    params.require(:status_changer_finalised).permit!
  end
end
