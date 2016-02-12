module StatusChanger
  class Finalised
    include ActiveModel::Model

    attr_reader :project
    attr_accessor :purchase_order

    delegate :print_jobs, to: :project

    def initialize(project, attributes = {})
      @project = project
      set_attr_accessors
      set_validations
      super(print_job_prices_hash.merge(attributes))
    end

    def save
      if project.sold?
        if valid?
          update_project_and_print_jobs
        end
      else
      # TODO raise an error if project is not sold
      end
    rescue ActiveRecord::RecordInvalid => e
      false
    end

    private

    def update_project_and_print_jobs
      project.transaction do
        project.update!(purchase_order: purchase_order, status: "finalised")
        print_jobs.each do |pj|
          update_hash = print_job_update_hash(pj.id)
          pj.update!(update_hash)
        end
      end
    end

    def set_attr_accessors
      print_jobs.map(&:id).each do |print_job_id|
        self.class.class_eval do
          attr_accessor "print_job_#{ print_job_id }_envisage_sale_price".to_sym
          attr_accessor "print_job_#{ print_job_id }_envisage_trade_sale_price".to_sym
          attr_accessor "print_job_#{ print_job_id }_envisage_to_my_sale_price".to_sym
          attr_accessor "print_job_#{ print_job_id }_my_sale_price".to_sym
        end
      end
    end

    def set_validations
      print_jobs.map(&:id).each do |print_job_id|
        self.class.class_eval do
          validates "print_job_#{ print_job_id }_envisage_sale_price".to_sym, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
          validates "print_job_#{ print_job_id }_envisage_trade_sale_price".to_sym, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
          validates "print_job_#{ print_job_id }_envisage_to_my_sale_price".to_sym, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
          validates "print_job_#{ print_job_id }_my_sale_price".to_sym, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
        end
      end
    end

    def print_job_prices_hash
      print_jobs.each_with_object({}) do |pj, h|
        h["print_job_#{ pj.id }_envisage_sale_price".to_sym] = pj.envisage_sale_price
        h["print_job_#{ pj.id }_envisage_trade_sale_price".to_sym] = pj.envisage_trade_sale_price
        h["print_job_#{ pj.id }_envisage_to_my_sale_price".to_sym] = pj.envisage_to_my_sale_price
        h["print_job_#{ pj.id }_my_sale_price".to_sym] = pj.my_sale_price
      end
    end

    def print_job_update_hash(print_job_id)
      h = prefixed_hash(print_job_id)
      non_prefixed_hash(h, print_job_id)
    end

    def prefixed_hash(print_job_id)
      instance_values.select{|k,v| k.start_with?("print_job_#{ print_job_id }") }
    end

    def non_prefixed_hash(hash, print_job_id)
      %w( envisage_sale_price envisage_trade_sale_price envisage_to_my_sale_price my_sale_price).each do |attr_name|
        hash[attr_name] = hash.delete("print_job_#{ print_job_id }_#{ attr_name }")
      end
      hash
    end
  end
end

