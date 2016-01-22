require 'rails_helper'
#  rspec --tag 'mileage_presenter'
RSpec.describe MileagePresenter, type: :presenter, mileage_presenter: true do
  let(:mileage) { build(:mileage) }
  subject(:mileage_presenter) { MileagePresenter.new(object: mileage, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:miles).to(:mileage) }
  end

  describe 'standard mileage' do
    it 'returns the mileage text' do
      expect(mileage_presenter.mileage_text).to eq(pluralize(mileage.miles, "mile"))
    end

    it 'returns the link' do
      expect(mileage_presenter.edit_link).to eq(edit_mileage_path(mileage))
    end

    it 'returns the edit link' do
      expect(mileage_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_mileage_path(mileage))
    end

    it 'returns the edit link with custom text' do
      expect(mileage_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_mileage_path(mileage))
    end
  end
end
