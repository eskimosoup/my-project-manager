require 'rails_helper'
#  rspec --tag 'customer_presenter'
RSpec.describe CustomerPresenter, type: :presenter, customer_presenter: true do
  let(:customer) { build(:customer) }
  subject(:customer_presenter) { CustomerPresenter.new(object: customer, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:customer) }
    it { should delegate_method(:credit_limit).to(:customer) }
    it { should delegate_method(:amount_on_credit).to(:customer) }
  end

  describe 'standard customer' do
    it 'returns the linked customer name' do
      expect(customer_presenter.linked_content).to eq(link_to customer.name, customer)
    end

    it 'returns the custom linked customer name' do
      expect(customer_presenter.linked_content('View')).to eq(link_to 'View', customer)
    end

    it 'returns the credit limit currency formatted' do
      expect(customer_presenter.credit_limit_currency).to eq(number_to_currency customer.credit_limit)
    end

    it 'returns the amount on credit currency formatted' do
      expect(customer_presenter.amount_on_credit_currency).to eq(number_to_currency customer.amount_on_credit)
    end

    it 'returns the projects' do
      expect(customer_presenter.projects).to eq(customer.projects)
    end
  end
end
