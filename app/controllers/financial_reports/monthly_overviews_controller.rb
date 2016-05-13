module FinancialReports
  class MonthlyOverviewsController < ::ApplicationController
    def show
      @my_projects = Project.my_brands.finalised_year(params[:year]).finalised_month(params[:month])
      @envisage_projects = Project.envisage_brands.finalised_year(params[:year]).finalised_month(params[:month])
    end
  end
end
