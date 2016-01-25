require 'rails_helper'
#  rspec --tag 'job_specification_presenter'
RSpec.describe JobSpecificationPresenter, type: :presenter, job_specification_presenter: true do
  let(:job_specification) { build(:job_specification) }
  subject(:job_specification_presenter) { JobSpecificationPresenter.new(object: job_specification, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:hours).to(:job_specification) }
    it { should delegate_method(:quoted?).to(:job_specification) }
  end

  describe 'standard job specification' do
    it 'returns the time' do
      expect(job_specification_presenter.time).to eq(pluralize(job_specification.hours, "hour"))
    end

    it '#edit_path' do
      expect(job_specification_presenter.edit_path).to eq(edit_job_specification_path(job_specification))
    end

    it 'returns the edit link' do
      expect(job_specification_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_job_specification_path(job_specification))
    end

    it 'returns the edit link with custom text' do
      expect(job_specification_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_job_specification_path(job_specification))
    end
  end

  context "quoted print job" do
    it "#octicon_edit_link" do
      allow(job_specification).to receive(:quoted?).and_return(true)

      link = link_to "#{ view.octicon('pencil') } #{ pluralize(job_specification.hours, "hour") }".html_safe, 
        edit_job_specification_path(job_specification), class: 'basic-listing-link'

      expect(job_specification_presenter.octicon_edit_link).to eq(link)
    end

    it "#delete_link" do
      allow(job_specification).to receive(:quoted?).and_return(true)

      link = button_to 'Remove', job_specification_path(job_specification), method: :delete,
        data: { confirm: 'Are you sure?', disable_with: 'processing...' },
        class: 'secondary-action-button'

      expect(job_specification_presenter.delete_link).to eq(link)
    end
  end

  context "not quoted print job" do
    it "#octicon_edit_link" do
      allow(job_specification).to receive(:quoted?).and_return(false)

      expect(job_specification_presenter.octicon_edit_link).to eq(pluralize(job_specification.hours, "hour"))
    end

    it "#delete_link" do
      allow(job_specification).to receive(:quoted?).and_return(false)

      expect(job_specification_presenter.delete_link).to eq(nil)
    end
  end
end
