class AccountManagementsController < ApplicationController
  before_action :set_project, only: [:new, :create]
  before_action :set_account_management, except: [:new, :create]

  def new
    @account_management = AccountManagement.new
  end

  def create
    @account_management = @project.account_managements.new(account_management_params)
    if @account_management.save
      redirect_to @project, notice: "Account management successfully added"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @account_management.update(account_management_params)
      redirect_to @account_management.project, notice: "Account management successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @account_management.destroy
    redirect_to @account_management.project, notice: "Account management successfully destroyed"
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_account_management
    @account_management = AccountManagement.find(params[:id])
  end

  def account_management_params
    params.require(:account_management).permit(:hours)
  end
end
