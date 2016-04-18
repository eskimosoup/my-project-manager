class ContactsController < ApplicationController
  def index
    @customer = find_customer
    @contacts = @customer.contacts
  end

  def new
    @customer = find_customer
    @contact = @customer.contacts.new
  end

  def create
    @customer = find_customer
    @contact = @customer.contacts.new(contact_params)
    if @contact.save
      redirect_to customer_contacts_path(@customer), notice: "Contact created"
    else
      render :new
    end
  end

  def edit
    @contact = find_contact
  end

  def update
    @contact = find_contact
    if @contact.update(contact_params)
      redirect_to customer_contacts_path(@contact.customer_id)
    else
      render :edit
    end
  end

  private

  def find_customer
    Customer.find(params[:customer_id])
  end

  def find_contact
    Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:forename, :surname, :email, :phone, :role)
  end
end
