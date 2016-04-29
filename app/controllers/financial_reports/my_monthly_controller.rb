module FinancialReports
  class MyMonthlyController < ApplicationController
    def index
      @reports = FinancialReports::MyMonthlyQuery.new.results
    end
  end
end
