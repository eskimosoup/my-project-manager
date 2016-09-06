class AmountInvoice < Invoice
  def to_partial_path
    "invoices/#{ type.underscore }"
  end
end
