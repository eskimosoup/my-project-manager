require 'rails_helper'
#  rspec --tag 'mileage_presenter'
RSpec.describe MileagePresenter, type: :presenter, mileage_presenter: true do
  let(:mileage) { build(:mileage) }
  subject(:mileage_presenter) { MileagePresenter.new(object: mileage, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:miles).to(:mileage) }
    it { should delegate_method(:quoted?).to(:mileage) }
  end

  describe 'standard mileage' do
    it 'returns the mileage text' do
      expect(mileage_presenter.mileage_text).to eq(pluralize(mileage.miles, "mile"))
    end

    it '#edit_path' do
      expect(mileage_presenter.edit_path).to eq(edit_mileage_path(mileage))
    end

    it 'returns the edit link' do
      expect(mileage_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_mileage_path(mileage))
    end

    it 'returns the edit link with custom text' do
      expect(mileage_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_mileage_path(mileage))
    end
  end

  context "quoted print job" do
    it "#octicon_edit_link" do
      allow(mileage).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ pluralize(mileage.miles, "mile") }".html_safe, 
        edit_mileage_path(mileage), class: 'basic-listing-link'

      expect(mileage_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(mileage).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', mileage_path(mileage), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(mileage_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it "#octicon_edit_link" do
      allow(mileage).to receive(:quoted?).and_return(false)

      expect(mileage_presenter.octicon_edit_link).to eq(pluralize(mileage.miles, "mile"))
    end

    it "#delete_link" do
      allow(mileage).to receive(:quoted?).and_return(false)

      expect(mileage_presenter.delete_link).to eq(nil)
    end
  end
end
