require 'rails_helper'
#  rspec --tag 'product_item_presenter'
RSpec.describe ProductItemPresenter, type: :presenter, product_item_presenter: true do
  let(:product_item) { build(:product_item) }
  subject(:product_item_presenter) { ProductItemPresenter.new(object: product_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:product_item) }
    it { should delegate_method(:area).to(:product_item) }
  end

  describe 'standard product_item' do
    it 'returns the link' do
      expect(product_item_presenter.edit_link).to eq(edit_product_item_path(product_item))
    end

    it 'returns the edit link' do
      expect(product_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_product_item_path(product_item))
    end

    it 'returns the edit link with custom text' do
      expect(product_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_product_item_path(product_item))
    end
  end
end
