class InvoiceSearch
  include ActiveModel::Model
  attr_reader :paid, :customer_id
  STATUSES = [["Paid", true], ["Unpaid", false]]

  def initialize(params = {})
    @paid = cast_to_boolean(params[:paid])
    @customer_id = cast_to_integer(params[:customer_id])
  end

  def results
    results = Invoice.all
    results = results.merge(Invoice.paid) if search_paid?
    results = results.merge(Invoice.unpaid) if search_unpaid?
    results = results.merge(Invoice.for_customer(customer_id))
    results
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "My::InvoiceSearch")
  end

  private

  def search_paid?
    paid == true
  end

  def search_unpaid?
    paid == false
  end

  def cast_to_integer(input)
    return if input.nil? || input.blank?
    Integer(input)
  end

  def cast_to_boolean(input)
    return if input.nil?
    return input if [true, false].include?(input)
    if input == "true"
      true
    else
      false
    end
  end
end
