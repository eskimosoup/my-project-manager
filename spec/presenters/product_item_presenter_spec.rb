require 'rails_helper'
#  rspec --tag 'product_item_presenter'
RSpec.describe ProductItemPresenter, type: :presenter, product_item_presenter: true do
  let(:product_item) { build(:product_item) }
  subject(:product_item_presenter) { ProductItemPresenter.new(object: product_item, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:product_item) }
    it { should delegate_method(:area).to(:product_item) }
    it { should delegate_method(:quoted?).to(:product_item) }
  end

  describe 'standard product_item' do
    it '#edit_path' do
      expect(product_item_presenter.edit_path).to eq(edit_product_item_path(product_item))
    end

    it 'returns the edit link' do
      expect(product_item_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_product_item_path(product_item))
    end

    it 'returns the edit link with custom text' do
      expect(product_item_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_product_item_path(product_item))
    end

    context "quoted print job" do
      it '#octicon_edit_link' do
        allow(product_item).to receive(:quoted?).and_return(true)

        link = link_to "#{ view.octicon('pencil') } #{ product_item.name } #{ view.format_area(product_item.area) }".html_safe, edit_product_item_path(product_item), class: 'product-item-link'

        expect(product_item_presenter.octicon_edit_link).to eq(link)
      end

      it "#delete_link" do
        allow(product_item).to receive(:quoted?).and_return(true)

        link = button_to 'Remove', product_item_path(product_item), method: :delete,
          data: { confirm: 'Are you sure?', disable_with: 'processing...' },
          class: 'secondary-action-button'

        expect(product_item_presenter.delete_link).to eq(link)
      end
    end

    context "not quoted print job" do
      it '#octicon_edit_link' do
        allow(product_item).to receive(:quoted?).and_return(false)

        content = "#{ product_item.name } #{ "#{ product_item.area }m<sup>2</sup>".html_safe }".html_safe
        
        expect(product_item_presenter.octicon_edit_link).to eq(content)
      end

      it "#delete_link" do
        allow(product_item).to receive(:quoted?).and_return(false)

        expect(product_item_presenter.delete_link).to eq(nil)
      end
    end
  end
end
