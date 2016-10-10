module FinancialReports
  class MonthlyOverviewsController < ::ApplicationController
    def show
      @my_projects = Project.includes(:customer).my_brands.finalised_year(params[:year]).finalised_month(params[:month])
      @envisage_projects = Project.includes(:customer).envisage_brands.finalised_year(params[:year]).finalised_month(params[:month])
    end

    def archive
    end
  end
end
