class Customer::PaymentsController < Customer::InvoicesController
  def new
    @invoice = find_invoice
  end

  def create
    @invoice = find_invoice
    invoice_payment = InvoicePayment.new(invoice: @invoice, stripe_token: params["stripeToken"])
    if invoice_payment.save
      redirect_to customer_invoice_path(@invoice), notice: "Invoice Paid"
    else
      render :new
    end
  end

  private

  def find_invoice
    Invoice.friendly.find(params[:invoice_id])
  end
end
