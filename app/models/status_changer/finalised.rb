module StatusChanger
  class Finalised
    include ActiveModel::Model

    attr_accessor :purchase_order

    validate :validate_print_job_forms

    def initialize(project, attributes = {})
      @project = project
      @print_jobs = project.print_jobs
      super(attributes)
    end

    def print_jobs_form_objects
      @print_jobs_form_objects ||= print_jobs.map do |print_job|
        PrintJobs::FinaliserForm.new(print_job, print_job_finaliser_attributes(print_job)) 
      end
    end
    
    def print_jobs_form_objects_attributes=(print_jobs_form_objects_attributes)
      print_jobs_form_objects_attributes.each do |index, attributes|
        print_jobs_form_objects[index.to_i].update(attributes)
      end
    end

    def save
      if project.sold?
        if valid?
          update_project_and_print_jobs
          send_emails
        end
      else
      # TODO raise an error if project is not sold
      end
    rescue ActiveRecord::RecordInvalid => e
      false
    end

    private

    attr_reader :project, :print_jobs

    def update_project_and_print_jobs
      project.transaction do
        project.update!(purchase_order: purchase_order, status: "finalised")
        print_jobs_form_objects.each do |pj|
          pj.save
        end
      end
    end

    def send_emails
      EnvisageMailer.project_finalised(project).deliver_now
      MyMailer.project_finalised(project).deliver_now if project.my_brand?
    end

    def print_job_finaliser_attributes(print_job)
      print_job.attributes.slice("envisage_sale_price", "envisage_trade_sale_price",
                                 "envisage_to_my_sale_price", "my_sale_price")
    end
    
    def validate_print_job_forms
      print_jobs_form_objects.each do |print_job_form|
        promote_print_job_errors(print_job_form) if print_job_form.invalid?
      end
    end

    def promote_print_job_errors(print_job_form)
      print_job_form.errors.each do |attr, message|
        errors.add("#{ print_job_form.name } #{ attr }", message)
      end
    end

  end
end

