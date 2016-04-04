class VehicleWrapPrintJobCreator
  include ActiveModel::Model

  validates :project, presence: true
  validates :vehicle_wrap, presence: true

  def initialize(vehicle_wrap_id:, project_id:)
    @vehicle_wrap_id = vehicle_wrap_id
    @project_id = project_id
  end

  def vehicle_wrap
    @vehicle_wrap ||= VehicleWrap.find_by(id: vehicle_wrap_id)
  end

  def project
    @project ||= Project.find_by(id: project_id)
  end

  def save
    return if invalid?
    ActiveRecord::Base.transaction do
      print_job.save!
      account_managements.each(&:save!)
      designs.each(&:save!)
      job_specifications.each(&:save!)
      labours.each(&:save!)
      product_items.each(&:save!)
      mileages.each(&:save!)
      sundry_items.each(&:save!)
      supporting_product_items.each(&:save!)
    end
  end

  def print_job
    @print_job ||= project.print_jobs.build(
      name: name_from_vehicle_wrap,
      envisage_sale_price: vehicle_wrap.envisage_override_price,
      envisage_trade_sale_price: vehicle_wrap.envisage_trade_override_price,
      envisage_to_my_sale_price: vehicle_wrap.envisage_to_my_override_price,
      my_sale_price: vehicle_wrap.envisage_to_my_override_price
    )
  end

  def account_managements
    @account_managements ||= vehicle_wrap.account_managements.map do |vehicle_wrap_account_management|
      print_job.account_managements.build(hours: vehicle_wrap_account_management.hours)
    end
  end

  def designs
    @designs ||= vehicle_wrap.designs.map do |vehicle_wrap_design|
      print_job.designs.build(hours: vehicle_wrap_design.hours)
    end
  end

  def job_specifications
    @job_specifications ||= vehicle_wrap.job_specifications.map do |vehicle_wrap_job_specification|
      print_job.job_specifications.build(hours: vehicle_wrap_job_specification.hours)
    end
  end

  def labours
    @labours ||= vehicle_wrap.labours.map do |vehicle_wrap_labour|
      print_job.labour_items.build(
        hours: vehicle_wrap_labour.hours,
        labour_id: vehicle_wrap_labour.labour_id
      )
    end
  end

  def product_items
    @product_items ||= vehicle_wrap.materials.map do |vehicle_wrap_material|
      print_job.product_items.build(
        area: vehicle_wrap_material.area, 
        product_id: vehicle_wrap_material.product_id
      )
    end
  end

  def mileages
    @mileages ||= vehicle_wrap.mileages.map do |vehice_wrap_mileage|
      print_job.mileages.build(miles: vehice_wrap_mileage.miles)
    end
  end

  def sundry_items
    @sundry_items ||= vehicle_wrap.sundry_items.map do |vehicle_wrap_sundry_item|
      print_job.sundry_items.build(
        name: vehicle_wrap_sundry_item.name, 
        cost: vehicle_wrap_sundry_item.cost
      )
    end
  end

  def supporting_product_items
    @supporting_product_items ||= vehicle_wrap.supporting_materials.map do |vehicle_wrap_supporting_material|
      print_job.supporting_product_items.build(
        area: vehicle_wrap_supporting_material.area,
        supporting_product_id: vehicle_wrap_supporting_material.supporting_product_id
      )
    end
  end

  private

  attr_reader :project_id, :vehicle_wrap_id

  def name_from_vehicle_wrap
    [vehicle_wrap.vehicle_type_name, vehicle_wrap.name].join(" - ")
  end
end
