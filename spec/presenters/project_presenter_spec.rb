require 'rails_helper'
#  rspec --tag 'project_presenter'
RSpec.describe ProjectPresenter, type: :presenter, project_presenter: true do
  let(:project) { create(:project) }
  subject(:project_presenter) { ProjectPresenter.new(object: project, view_template: view) }

  describe 'delegations', :delegation do
    it { should delegate_method(:name).to(:project) }
    it { should delegate_method(:brand_price).to(:project) }
  end

  describe 'standard project' do
    it 'returns the link' do
      expect(project_presenter.link).to eq(project)
    end

    it 'returns the reference number' do
      expect(project_presenter.reference_number).to eq("#{project.customer.id}-#{project.id + 100}")
    end

    it 'returns the brand name' do
      expect(project_presenter.brand_name).to eq(project.brand.name)
    end

    it 'returns the linked project name' do
      expect(project_presenter.linked_content).to eq(link_to project.name, project)
    end

    it 'returns the linked project with custom text' do
      expect(project_presenter.linked_content('View this project')).to eq(link_to 'View this project', project)
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
      expect(project_presenter.download_pdf_link).to eq(link_to 'Download PDF', view.project_downloads_path(project.id, format: 'pdf'), target: '_blank', class: 'secondary-action-button download')
    end

    it 'returns the new print project link with default text' do
      expect(project_presenter.new_print_job_link).to eq(link_to 'Add Print Item', view.new_project_print_job_path(project_id: project.id), class: 'action-button')
    end

    it 'returns the new print project link with custom text' do
      expect(project_presenter.new_print_job_link('New Print Item')).to eq(link_to 'New Print Item', view.new_project_print_job_path(project_id: project.id), class: 'action-button')
    end

    it 'returns the brand price currency' do
      expect(project_presenter.brand_price_currency).to eq(number_to_currency project.brand_price)
    end

    context 'normal project' do
      let(:project) { build(:project, rush_job: false) }
      subject(:project_presenter) { ProjectPresenter.new(object: project, view_template: view) }

      it '#project_type' do
        expect(subject.job_type).to eq('Standard')
      end
    end

    context 'rush project' do
      let(:project) { build(:project, rush_job: true) }
      subject(:project_presenter) { ProjectPresenter.new(object: project, view_template: view) }

      it '#project_type' do
        expect(subject.job_type).to eq('Rush Job')
      end
    end

    context 'quoted project' do
      let(:project) { create(:quoted_project) }
      subject(:project_presenter) { ProjectPresenter.new(object: project, view_template: view) }

      it '#mark_sold' do
        button = button_to 'Mark As Sold', project_status_changer_path(project), method: :post,
          data: { disable_with: 'Processing...' }, params: { status: :sold }, class: 'secondary-action-button'
        expect(subject.mark_sold).to eq(button)
      end

      it '#mark_finalised' do
        expect(subject.mark_finalised).to eq(nil)
      end

      it '#envisage_job_sheet_link' do
        expect(subject.envisage_job_sheet_link).to eq(nil)
      end

      it '#my_job_sheet_link' do
        expect(subject.my_job_sheet_link).to eq(nil)
      end

      it "#invoices_link" do
        expect(subject.invoices_link).to eq(nil)
      end
    end

    context 'sold project' do
      let(:project) { create(:sold_project) }
      subject(:project_presenter) { ProjectPresenter.new(object: project, view_template: view) }

      it '#mark_sold' do
        expect(subject.mark_sold).to eq(nil)
      end

      it '#mark_finalised' do
        link = link_to('Finalise Project', new_project_project_finaliser_path(project),
                       data: { disable_with: 'Processing...' }, class: 'secondary-action-button')
        expect(subject.mark_finalised).to eq(link)
      end

      it '#envisage_job_sheet_link' do
        expect(subject.envisage_job_sheet_link).to eq(nil)
      end

      it '#my_job_sheet_link' do
        expect(subject.my_job_sheet_link).to eq(nil)
      end

      it "#invoices_link" do
        expect(subject.invoices_link).to eq(nil)
      end
    end

    context 'finalised project' do
      let(:project) { create(:finalised_project) }
      subject(:project_presenter) { ProjectPresenter.new(object: project, view_template: view) }

      it '#mark_sold' do
        expect(subject.mark_sold).to eq(nil)
      end

      it '#mark_finalised' do
        expect(subject.mark_finalised).to eq(nil)
      end

      it '#envisage_job_sheet_link' do
        expect(subject.envisage_job_sheet_link).to eq(link_to 'Download Envisage Job Sheet', project_envisage_job_sheet_path(project, format: 'pdf'))
      end

      it '#envisage_job_sheet_link with options' do
        expect(subject.envisage_job_sheet_link('Envisage Job Sheet', class: 'action-button')).to eq(link_to 'Envisage Job Sheet', project_envisage_job_sheet_path(project, format: 'pdf'), class: 'action-button')
      end

      it '#my_job_sheet_link' do
        expect(subject.my_job_sheet_link).to eq(link_to 'Download My Job Sheet', project_my_job_sheet_path(project, format: 'pdf'))
      end

      it '#my_job_sheet_link with options' do
        expect(subject.my_job_sheet_link('My Job Sheet', class: 'action-button')).to eq(link_to 'My Job Sheet', project_my_job_sheet_path(project, format: 'pdf'), class: 'action-button')
      end

      it "#invoices_link" do
        link = link_to("Invoices", project_invoices_path(project), class: "action-button")
        expect(subject.invoices_link).to eq(link)
      end
    end

    context 'completed project' do
      let(:project) { build_stubbed(:completed_project) }
      subject(:project_presenter) { ProjectPresenter.new(object: project, view_template: view) }

      it '#mark_sold' do
        expect(subject.mark_sold).to eq(nil)
      end

      it '#mark_finalised' do
        expect(subject.mark_finalised).to eq(nil)
      end

      it '#envisage_job_sheet_link' do
        expect(subject.envisage_job_sheet_link).to eq(nil)
      end

      it '#my_job_sheet_link' do
        expect(subject.my_job_sheet_link).to eq(nil)
      end

      it "#invoices_link" do
        link = link_to("Invoices", project_invoices_path(project), class: "action-button")
        expect(subject.invoices_link).to eq(link)
      end
    end
  end

  describe "#delivery_deadline" do
    it "has deadline" do
      project = build(:project)
      project_presenter = ProjectPresenter.new(object: project, view_template: view)

      expect(project_presenter.delivery_deadline).to eq(l project.delivery_deadline)
    end

    it "has no deadline" do
      project = build(:project, delivery_deadline: nil)
      project_presenter = ProjectPresenter.new(object: project, view_template: view)

      expect(project_presenter.delivery_deadline).to eq("No deadline")
    end
  end

  it "#notes" do
    project = build(:project, notes: "Some notes")
    project_presenter = ProjectPresenter.new(object: project, view_template: view)

    expect(project_presenter.notes).to eq(simple_format("Some notes"))
  end
end
