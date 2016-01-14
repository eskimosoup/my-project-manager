class AddressPresenter < BasePresenter
  presents :address

  def line_1
    format_line(address.line_1) if address.line_1.present?
  end

  def line_2
    format_line(address.line_2) if address.line_2.present?
  end

  def line_3
    format_line(address.line_3) if address.line_3.present?
  end

  def city
    format_line(address.city) if address.city.present?
  end

  def postcode
    format_line(address.postcode) if address.postcode.present?
  end
  private

  def format_line(line)
    "#{ line }<br/>".html_safe
  end
end
