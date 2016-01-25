module StatusChanger
  class Sold
    attr_reader :project

    def initialize(project)
      @project = project
    end

    def save
      case project.status
      when "quoted"
        update_quoted_project
      end
    rescue ActiveRecord::RecordInvalid => e
      false
    end

    private

    def update_quoted_project
      project.transaction do
        project.sold!
        project.print_jobs.each do |print_job|
          process_print_job!(print_job)
        end
      end
    end

    def process_print_job!(print_job)
      print_job.set_prices!
      ProductCostsCreator.new(print_job.id, print_job.product_items).create_product_costs!
      SupportingProductCostsCreator.new(print_job.id, print_job.supporting_product_items).create_supporting_product_costs!
      set_sundry_costs!(print_job)
      MileageCostsCreator.new(print_job.id, print_job.mileages).create_mileage_cost!
    end

    def set_sundry_costs!(print_job)
      print_job.sundry_items.each do |sundry_item|
        print_job.sundry_costs.create!(sundry_item.attributes.select{|k,v| %w( name cost ).include?(k) })
      end
    end

  end
end
