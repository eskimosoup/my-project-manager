module FinancialReports
  class ProjectsController < ::ApplicationController
    def not_invoiced_in_full
      @projects = Project.includes(:customer, :invoices)
                         .finalised
                         .reject { |x| x.invoices.sum(:amount) == x.brand_price }
    end

    def not_paid_in_full
      @projects = Project.includes(:customer, :invoices)
                         .finalised
                         .reject { |x| x.brand_price == x.paid_invoices.sum(:amount) }
    end
  end
end
