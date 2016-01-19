class CustomerRegistration
  include ActiveModel::Model

  attr_accessor :customer_name, :customer_credit_limit, :contact_name,
    :contact_email, :contact_phone, :contact_role
  
  validate :validate_children

  def initialize(attributes = {})
    super
    @customer_credit_limit = set_customer_credit_limit(attributes[:customer_credit_limit])
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        customer.save!
        contact.save!
      end
    end
  end

  def customer
    @customer ||= Customer.new(name: customer_name, credit_limit: customer_credit_limit)
  end

  private

  def contact
    @contact ||= customer.contacts.new(name: contact_name, email: contact_email, phone: contact_phone, 
                                role: contact_role, made_main_contact_at: Time.zone.now)
  end

  def validate_children
    promote_errors(customer) if customer.invalid?
    promote_errors(contact) if contact.invalid?
  end

  def promote_errors(child)
    child.errors.each do |attribute, message|
      errors.add("#{ child.class.name.underscore }_#{ attribute }", message)
    end
  end

  def set_customer_credit_limit(input)
    return 0.00 if input.blank?
    input
  end

end
