class FinalisersController < ApplicationController

  def new
    @project = find_project
    @finalised_status_changer = StatusChanger::Finalised.new(@project)
  end

  def create
    @project = find_project
    @finalised_status_changer = StatusChanger::Finalised.new(@project, status_changer_finalised_params)
    if @finalised_status_changer.save
      redirect_to @project, notice: "Project successfully finalised"
    else
      render :new
    end
  end

  private

  def find_project
    Project.find(params[:project_id])
  end

  def status_changer_finalised_params
    params.require(:status_changer_finalised).permit!
  end
end
