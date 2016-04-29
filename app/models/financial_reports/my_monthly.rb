class FinancialReports::MyMonthly
  attr_reader :sales, :costs, :month, :year

  def initialize(sales:, costs:, month: , year:)
    @sales = sales
    @costs = costs
    @month = Date::MONTHNAMES[month]
    @year = year.to_i
  end
end

