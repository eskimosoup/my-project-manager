require 'rails_helper'
#  rspec --tag 'sundry_item_presenter'
RSpec.describe SundryItemPresenter, type: :presenter, sundry_item_presenter: true do
  let(:sundry_item) { build(:sundry_item) }
  subject(:sundry_item_presenter) { SundryItemPresenter.new(object: sundry_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:sundry_item) }
    it { should delegate_method(:cost).to(:sundry_item) }
  end

  describe 'standard sundry_item' do
    it 'returns the sundry_item text' do
      expect(sundry_item_presenter.cost_currency).to eq(number_to_currency cost)
    end

    it 'returns the link' do
      expect(sundry_item_presenter.edit_link).to eq(edit_sundry_item_path(sundry_item))
    end

    it 'returns the edit link' do
      expect(sundry_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_sundry_item_path(sundry_item))
    end

    it 'returns the edit link with custom text' do
      expect(sundry_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_sundry_item_path(sundry_item))
    end
  end
end
