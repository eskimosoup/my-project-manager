require 'rails_helper'
#  rspec --tag 'sundry_item_presenter'
RSpec.describe SundryItemPresenter, type: :presenter, sundry_item_presenter: true do
  let(:sundry_item) { build(:sundry_item) }
  subject(:sundry_item_presenter) { SundryItemPresenter.new(object: sundry_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:sundry_item) }
    it { should delegate_method(:cost).to(:sundry_item) }
    it { should delegate_method(:quoted?).to(:sundry_item) }
  end

  describe 'standard sundry_item' do
    it 'returns the sundry_item text' do
      expect(sundry_item_presenter.cost_currency).to eq(number_to_currency sundry_item.cost)
    end

    it '#edit_path' do
      expect(sundry_item_presenter.edit_path).to eq(edit_sundry_item_path(sundry_item))
    end

    it 'returns the edit link' do
      expect(sundry_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_sundry_item_path(sundry_item))
    end

    it 'returns the edit link with custom text' do
      expect(sundry_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_sundry_item_path(sundry_item))
    end
  end

  context "quoted print job" do
    it "#octicon_edit_link" do
      allow(sundry_item).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ sundry_item.name } #{ number_to_currency(sundry_item.cost) }".html_safe, edit_sundry_item_path(sundry_item), class: 'basic-listing-link'

      expect(sundry_item_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(sundry_item).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', sundry_item_path(sundry_item), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(sundry_item_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it "#octicon_edit_link" do
      allow(sundry_item).to receive(:quoted?).and_return(false)

      expect(sundry_item_presenter.octicon_edit_link).to eq("#{ sundry_item.name } #{ number_to_currency(sundry_item.cost) }")
    end

    it "#delete_link" do
      allow(sundry_item).to receive(:quoted?).and_return(false)

      expect(sundry_item_presenter.delete_link).to eq(nil)
    end
  end
end
