class CustomerRegistration
  include ActiveModel::Model

  attr_accessor :customer_name, :customer_credit_limit, :customer_payment_days,
    :contact_forename, :contact_surname, :contact_email, :contact_phone, :contact_role

  validate :validate_children

  def initialize(attributes = {})
    super
    @customer_credit_limit = attributes.fetch(:customer_credit_limit, customer.credit_limit)
    @customer_payment_days = attributes.fetch(:customer_payment_days, customer.payment_days)
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
    @customer ||= Customer.new(customer_attributes)
  end

  private

  def customer_attributes
    {
      name: customer_name,
      credit_limit: customer_credit_limit,
      payment_days: customer_payment_days,
    }.compact
  end

  def contact_attributes
    {
      forename: contact_forename,
      surname: contact_surname,
      email: contact_email,
      phone: contact_phone,
      role: contact_role,
      made_main_contact_at: Time.zone.now
    }
  end

  def contact
    @contact ||= customer.contacts.new(contact_attributes)
  end

  def validate_children
    promote_errors(customer) if customer.invalid?
    promote_errors(contact) if contact.invalid?
  end

  def promote_errors(child)
    child.errors.each do |attribute, message|
      errors.add("#{child.class.name.underscore}_#{attribute}", message)
    end
  end
end
