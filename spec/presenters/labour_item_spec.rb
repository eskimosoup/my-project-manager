require 'rails_helper'
#  rspec --tag 'labour_item_presenter'
RSpec.describe LabourItemPresenter, type: :presenter, labour_item_presenter: true do
  let(:labour_item) { build(:labour_item) }
  subject(:labour_item_presenter) { LabourItemPresenter.new(object: labour_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:labour_item) }
    it { should delegate_method(:hours).to(:labour_item) }
    it { should delegate_method(:quoted?).to(:labour_item) }
  end

  describe 'standard labour_item' do
    it 'returns the time' do
      expect(labour_item_presenter.time).to eq(pluralize(labour_item.hours, "hour"))
    end

    it '#edit_path' do
      expect(labour_item_presenter.edit_path).to eq(edit_labour_item_path(labour_item))
    end

    it 'returns the edit link' do
      expect(labour_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_labour_item_path(labour_item))
    end

    it 'returns the edit link with custom text' do
      expect(labour_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_labour_item_path(labour_item))
    end
  end

  context "quoted print job" do
    it '#octicon_edit_link' do
      allow(labour_item).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ labour_item.name } #{ pluralize(labour_item.hours, 'hour' ) }".html_safe, edit_labour_item_path(labour_item), class: 'basic-listing-link'

      expect(labour_item_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(labour_item).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', labour_item_path(labour_item), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(labour_item_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it '#octicon_edit_link' do
      allow(labour_item).to receive(:quoted?).and_return(false)

      content = "#{ labour_item.name } #{ pluralize(labour_item.hours, 'hour') }".html_safe

      expect(labour_item_presenter.octicon_edit_link).to eq(content)
    end

    it "#delete_link" do
      allow(labour_item).to receive(:quoted?).and_return(false)

      expect(labour_item_presenter.delete_link).to eq(nil)
    end
  end
end
