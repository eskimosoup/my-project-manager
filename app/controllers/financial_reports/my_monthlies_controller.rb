module FinancialReports
  class MyMonthliesController < ApplicationController
    def show
      @reports = FinancialReports::MyMonthlyQuery.new.results
    end
  end
end
