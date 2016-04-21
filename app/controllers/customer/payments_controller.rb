class Customer::PaymentsController < Customer::InvoicesController
  before_action :load_brands

  def new
    @invoice = find_invoice
    @authorised = @invoice.project.billing_address.postcode.casecmp(params[:postcode].downcase).zero? if params[:postcode].present?
  end

  def create
    # raise params.to_yaml
    @authorised = true
    @invoice = find_invoice
    invoice_payment = InvoicePayment.new(
      invoice: @invoice,
      stripe_token: params[:stripeToken],
      email: params[:email]
    )
    if invoice_payment.save
      redirect_to customer_invoice_path(@invoice), notice: 'Invoice Paid'
    else
      render :new
    end
  end

  private

  def find_invoice
    Invoice.friendly.find(params[:invoice_id])
  end

  def load_brands
    @brands = Brand.where('name LIKE ?', 'My %')
  end
end
