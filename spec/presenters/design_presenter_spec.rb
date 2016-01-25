require 'rails_helper'
#  rspec --tag 'design_presenter'
RSpec.describe DesignPresenter, type: :presenter, design_presenter: true do
  let(:design) { build(:design) }
  subject(:design_presenter) { DesignPresenter.new(object: design, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:hours).to(:design) }
    it { should delegate_method(:quoted?).to(:design) }
  end

  describe 'standard design' do
    it 'returns the time' do
      expect(design_presenter.time).to eq(pluralize(design.hours, "hour"))
    end

    it '#edit_path' do
      expect(design_presenter.edit_path).to eq(edit_design_path(design))
    end

    it 'returns the edit link' do
      expect(design_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_design_path(design))
    end

    it 'returns the edit link with custom text' do
      expect(design_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_design_path(design))
    end
  end

  context "quoted print job" do
    it '#octicon_edit_link' do
      allow(design).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ pluralize(design.hours, 'hour' ) }".html_safe, edit_design_path(design), class: 'basic-listing-link'

      expect(design_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(design).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', design_path(design), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(design_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it '#octicon_edit_link' do
      allow(design).to receive(:quoted?).and_return(false)

      content = "#{ pluralize(design.hours, 'hour') }".html_safe

      expect(design_presenter.octicon_edit_link).to eq(content)
    end

    it "#delete_link" do
      allow(design).to receive(:quoted?).and_return(false)

      expect(design_presenter.delete_link).to eq(nil)
    end
  end
end
