require 'rails_helper'
#  rspec --tag 'project_presenter'
RSpec.describe ProjectPresenter, type: :presenter, project_presenter: true do
  let(:project) { build(:project) }
  subject(:project_presenter) { ProjectPresenter.new(object: project, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:project) }
  end

  describe 'standard project' do
    it 'returns the link' do
      expect(project_presenter.link).to eq(project)
    end

    it 'returns the linked project name' do
      expect(project_presenter.linked_content).to eq(link_to project.name, view.project_path(project.id))
    end

    it 'returns the linked project with custom text' do
      expect(project_presenter.linked_content('View this project')).to eq(link_to 'View this project', view.project)
    end

    it 'returns the status' do
      expect(project_presenter.status).to eq(project.status.humanize)
    end

    it 'returns the project name' do
      expect(project_presenter.customer_name).to eq(project.customer.name)
    end

    it 'returns the description - html formatted' do
      expect(project_presenter.description).to eq(simple_format project.description)
    end

    it 'returns the PDF download link with default text' do
      expect(project_presenter.download_pdf_link).to eq(link_to 'Download PDF', view.project_downloads_path(project.id, format: 'pdf'), target: '_blank', class: 'action-button download')
    end

    it 'returns the new print project link with default text' do
      expect(project_presenter.new_print_job_link).to eq(link_to 'Add Print Item', view.new_project_print_job_path(project.id), class: 'action-button')
    end

    it 'returns the new print project link with custom text' do
      expect(project_presenter.new_print_job_link('New print item')).to eq(link_to 'New Print Item', view.new_project_print_job_path(project.id), class: 'action-button')
    end
  end
end
