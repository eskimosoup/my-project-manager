class My::UnpaidInvoicesController < ApplicationController
  def index
    @invoices = Invoice.unpaid.order(updated_at: :desc)
  end
end
