require 'rails_helper'
#  rspec --tag 'design_presenter'
RSpec.describe DesignPresenter, type: :presenter, design_presenter: true do
  let(:design) { build(:design) }
  subject(:design_presenter) { DesignPresenter.new(object: design, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:hours).to(:design) }
  end

  describe 'standard design' do
    it 'returns the time' do
      expect(design_presenter.time).to eq(pluralize(design.hours, "hour"))
    end

    it 'returns the link' do
      expect(design_presenter.edit_link).to eq(edit_design_path(design))
    end

    it 'returns the edit link' do
      expect(design_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_design_path(design))
    end

    it 'returns the edit link with custom text' do
      expect(design_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_design_path(design))
    end
  end
end
