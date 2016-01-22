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
    it '#edit_path' do
      expect(supporting_product_item_presenter.edit_path).to eq(edit_supporting_product_item_path(supporting_product_item))
    end

    it 'returns the edit link' do
      expect(supporting_product_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_supporting_product_item_path(supporting_product_item))
    end

    it 'returns the edit link with custom text' do
      expect(supporting_product_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_supporting_product_item_path(supporting_product_item))
    end
  end

  context "quoted print job" do
    it '#octicon_edit_link' do
      allow(supporting_product_item).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ supporting_product_item.name } #{ view.format_area(supporting_product_item.area) }".html_safe, edit_supporting_product_item_path(supporting_product_item), class: 'basic-listing-link'

      expect(supporting_product_item_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(supporting_product_item).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', supporting_product_item_path(supporting_product_item), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(supporting_product_item_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it '#octicon_edit_link' do
      allow(supporting_product_item).to receive(:quoted?).and_return(false)

      content = "#{ supporting_product_item.name } #{ "#{ supporting_product_item.area }m<sup>2</sup>".html_safe }".html_safe

      expect(supporting_product_item_presenter.octicon_edit_link).to eq(content)
    end

    it "#delete_link" do
      allow(supporting_product_item).to receive(:quoted?).and_return(false)

      expect(supporting_product_item_presenter.delete_link).to eq(nil)
    end
  end
end
