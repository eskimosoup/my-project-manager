require 'rails_helper'
#  rspec --tag 'print_job'
RSpec.describe PrintJobPresenter, type: :presenter, print_job_presenter: true do
  let(:print_job) { build_stubbed(:print_job) }
  subject(:print_job_presenter) { PrintJobPresenter.new(object: print_job, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:print_job) }
    it { should delegate_method(:brand_price).to(:print_job) }
  end

  describe 'standard print job' do
    it 'returns the brand price currency' do
      allow(print_job).to receive(:brand_price).and_return(12.00)
      expect(print_job_presenter.brand_price_currency).to eq(number_to_currency print_job.brand_price)
    end

    it 'returns the link' do
      expect(print_job_presenter.link).to eq(print_job)
    end

    it 'returns the view link' do
      expect(print_job_presenter.linked_content).to eq(link_to 'View', print_job)
    end

    it 'returns the link with custom text' do
      expect(print_job_presenter.linked_content('View this print item', class: 'print-job-view-link')).to eq(link_to 'View this print item', print_job, class: 'print-job-view-link')
    end

    it 'returns the delete button' do
      expect(print_job_presenter.delete_link).to eq(button_to 'Remove', print_job, method: :delete, data: { confirm: 'Are you sure?', disable_with: 'Processing' }, class: "secondary-action-button delete-job")
    end
  end

  context "standard job type" do
    let(:print_job) { build_stubbed(:print_job) }
    subject(:print_job_presenter) { PrintJobPresenter.new(object: print_job, view_template: view) }

    it "#job_type" do
      allow(print_job).to receive(:rush_job?).and_return(false)

      expect(subject.job_type).to eq("Standard")
      expect(print_job).to have_received(:rush_job?)
    end
  end

  context "rush job type" do
    let(:print_job) { build_stubbed(:print_job) }
    subject(:print_job_presenter) { PrintJobPresenter.new(object: print_job, view_template: view) }

    it "#job_type" do
      allow(print_job).to receive(:rush_job?).and_return(true)

      expect(subject.job_type).to eq("Rush Job")
      expect(print_job).to have_received(:rush_job?)
    end
  end
end
