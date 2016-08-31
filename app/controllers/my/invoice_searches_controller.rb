module My
  class InvoiceSearchesController < ApplicationController
    def create
      @invoice_search = InvoiceSearch.new(invoice_search_params)
      @invoices = @invoice_search.results.page(params[:page]).per(50)
      render "my/invoices/index"
    end

    private

    def invoice_search_params
      params.require(:my_invoice_search).permit(:customer_id, :paid)
    end
  end
end
