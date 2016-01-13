class CustomerPresenter < BasePresenter
  presents :customer
  delegate :name, :credit_limit, :amount_on_credit, to: :customer

  def link
    customer
  end

  def linked_content(content = customer.name)
    h.link_to content, link
  end

  def credit_limit_currency
    h.number_to_currency credit_limit
  end

  def amount_on_credit_currency
    h.number_to_currency amount_on_credit
  end

  def projects
    customer.projects
  end
end
