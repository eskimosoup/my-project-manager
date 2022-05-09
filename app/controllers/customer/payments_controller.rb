class Customer::PaymentsController < Customer::InvoicesController
  before_action :load_brands

  def new
    @invoice = find_invoice
    @authorised = @invoice.project.billing_address.postcode.gsub(/\s+/, '').casecmp(params[:postcode].downcase.gsub(/\s+/, '')).zero? if params[:postcode].present?
    if @invoice.paid?
      redirect_to(complete_customer_invoice_payment_url(@invoice))
    else
      @charge = invoice_payment.charge
    end
  end

  def create
    # @authorised = true
    # @invoice = find_invoice
    # if invoice_payment.save
    #   redirect_to customer_invoice_path(@invoice), notice: 'Invoice Paid'
    # else
    #   render :new
    # end
    head(:not_found)
  end

  def complete
    @authorised = true
    @invoice = find_invoice

    if params[:redirect_status] == 'succeeded' && @invoice.update(stripe_charge_id: params[:payment_intent], paid: true)
      redirect_to(complete_customer_invoice_payment_url(@invoice))
    elsif @invoice.paid?
      @complete = true
    end
  end

  private

  def invoice_payment
    InvoicePayment.new(
      invoice: @invoice,
      email: @invoice.project.customer.main_contact.email
    )
  end

  def find_invoice
    Invoice.friendly.find(params[:invoice_id])
  end

  def load_brands
    @brands = Brand.where('name LIKE ?', 'My %')
  end
end
