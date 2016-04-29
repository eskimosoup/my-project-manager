class FinancialReports::MyMonthlyQuery
  def new
  end

  def results
    PrintJob.select([sum_costs, sum_sales, extract_month.as("month"), extract_year.as("year")]).group([extract_month, extract_year]).order("year desc, month asc").map do |report_data|
      FinancialReports::MyMonthly.new(
        sales: report_data.sales,
        costs: report_data.costs,
        month: report_data.month,
        year: report_data.year
      )
    end
  end

  private

  def table
    PrintJob.arel_table
  end

  def sum_costs
    table[:envisage_to_my_sale_price].sum.as("costs")
  end

  def sum_sales
    table[:my_sale_price].sum.as("sales")
  end

  def extract_month
    table[:updated_at].extract("month")
  end

  def extract_year
    table[:updated_at].extract("year")
  end
end
