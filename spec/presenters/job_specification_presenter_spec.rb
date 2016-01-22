require 'rails_helper'
#  rspec --tag 'job_specification_presenter'
RSpec.describe JobSpecificationPresenter, type: :presenter, job_specification_presenter: true do
  let(:job_specification) { build(:job_specification) }
  subject(:job_specification_presenter) { JobSpecificationPresenter.new(object: job_specification, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:hours).to(:job_specification) }
  end

  describe 'standard job specification' do
    it 'returns the time' do
      expect(job_specification_presenter.time).to eq(pluralize(job_specification.hours, "hour"))
    end

    it 'returns the link' do
      expect(job_specification_presenter.edit_link).to eq(edit_job_specification_path(job_specification))
    end

    it 'returns the edit link' do
      expect(job_specification_presenter.edit_link_content).to eq(link_to 'Edit', view.edit_job_specification_path(job_specification))
    end

    it 'returns the edit link with custom text' do
      expect(job_specification_presenter.edit_link_content('Edit this product item')).to eq(link_to 'Edit this product item', view.edit_job_specification_path(job_specification))
    end
  end
end
