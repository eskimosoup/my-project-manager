require 'rails_helper'
#  rspec --tag 'labour_item_presenter'
RSpec.describe LabourItemPresenter, type: :presenter, labour_item_presenter: true do
  let(:labour_item) { build(:labour_item) }
  subject(:labour_item_presenter) { LabourItemPresenter.new(object: labour_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:labour_item) }
    it { should delegate_method(:hours).to(:labour_item) }
  end

  describe 'standard labour_item' do
    it 'returns the time' do
      expect(labour_item_presenter.time).to eq(pluralize(labour_item.hours, "hour"))
    end

    it 'returns the link' do
      expect(labour_item_presenter.edit_link).to eq(edit_labour_item_path(labour_item))
    end

    it 'returns the edit link' do
      expect(labour_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_labour_item_path(labour_item))
    end

    it 'returns the edit link with custom text' do
      expect(labour_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_labour_item_path(labour_item))
    end
  end
end
