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
      expect(project_presenter.linked_content).to eq(link_to project.name, project)
    end

    it 'returns the status' do
      expect(project_presenter.status).to eq(project.status.humanize)
    end

    it 'returns the project name' do
      expect(project_presenter.customer_name).to eq(project.customer.name)
    end
  end
end
