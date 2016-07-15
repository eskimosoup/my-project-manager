require 'rails_helper'
RSpec.describe MyServiceItemPresenter, type: :presenter do
  let(:my_service_item) { build_stubbed(:my_service_item) }
  subject(:my_service_item_presenter) { MyServiceItemPresenter.new(object: my_service_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:my_service_item) }
    it { should delegate_method(:cost).to(:my_service_item) }
    it { should delegate_method(:quoted?).to(:my_service_item) }
  end

  describe 'standard my_service_item' do
    it 'returns the my_service_item text' do
      expect(my_service_item_presenter.cost_currency).to eq(number_to_currency my_service_item.cost)
    end

    it '#edit_path' do
      expect(my_service_item_presenter.edit_path).to eq(edit_my_service_item_path(my_service_item))
    end

    it 'returns the edit link' do
      expect(my_service_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_my_service_item_path(my_service_item))
    end

    it 'returns the edit link with custom text' do
      expect(my_service_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_my_service_item_path(my_service_item))
    end
  end

  context "quoted print job" do
    it "#octicon_edit_link" do
      allow(my_service_item).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ my_service_item.name } #{ number_to_currency(my_service_item.cost) }".html_safe, edit_my_service_item_path(my_service_item), class: 'basic-listing-link'

      expect(my_service_item_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(my_service_item).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', my_service_item_path(my_service_item), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(my_service_item_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it "#octicon_edit_link" do
      allow(my_service_item).to receive(:quoted?).and_return(false)

      expect(my_service_item_presenter.octicon_edit_link).to eq("#{ my_service_item.name } #{ number_to_currency(my_service_item.cost) }")
    end

    it "#delete_link" do
      allow(my_service_item).to receive(:quoted?).and_return(false)

      expect(my_service_item_presenter.delete_link).to eq(nil)
    end
  end
end
