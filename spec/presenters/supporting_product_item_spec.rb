require 'rails_helper'
#  rspec --tag 'supporting_product_item_presenter' 
RSpec.describe SupportingProductItemPresenter, type: :presenter, supporting_product_item_presenter: true do
  let(:supporting_product_item) { build(:supporting_product_item) }
  subject(:supporting_product_item_presenter) { SupportingProductItemPresenter.new(object: supporting_product_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:supporting_product) }
    it { should delegate_method(:area).to(:supporting_product) }
  end

  describe 'standard supporting_product_item' do
    it 'returns the link' do
      expect(supporting_product_item_presenter.edit_link).to eq(edit_supporting_product_item_path(supporting_product_item))
    end

    it 'returns the edit link' do
      expect(supporting_product_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_supporting_product_item_path(supporting_product_item))
    end

    it 'returns the edit link with custom text' do
      expect(supporting_product_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_supporting_product_item_path(supporting_product_item))
    end
  end
end
