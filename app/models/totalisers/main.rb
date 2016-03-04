class Totalisers::Main

  def initialize(project:, for_my: true)
    @project = project
    @for_my = for_my
  end

  def account_management_totaliser
    return nil unless should_have_account_management_totaliser?
    Totalisers::Hours.new(name: "My Account Management", items: account_managements)
  end

  def design_totaliser
    return nil unless should_have_design_totaliser?
    Totalisers::Hours.new(name: "My Design", items: designs)
  end

  def job_specification_totaliser
    return nil unless job_specifications.present?
    Totalisers::Hours.new(name: "Job Specification", items: job_specifications)
  end

  def labour_totalisers
    grouped_labour_items.map do |name, labour_items|
      Totalisers::Hours.new(name: name, items: labour_items)
    end
  end

  def mileage_totaliser
    return nil unless mileages.present?
    Totaliser::Mileage.new(mileages: mileages)
  end

  def product_totalisers
    grouped_product_items.map do |name, product_items|
      Totalisers::Area.new(name: name, items: product_items)
    end
  end

  def supporting_product_totalisers
    grouped_supporting_product_items.map do |name, supporting_product_items|
      Totalisers::Area.new(name: name, items: supporting_product_items)
    end
  end

  def all_totalisers
    [*product_totalisers, *supporting_product_totalisers, job_specification_totaliser,
     *labour_totalisers, mileage_totaliser, design_totaliser, account_management_totaliser].compact
  end

  private

  attr_reader :project, :for_my

  def should_have_account_management_totaliser?
    for_my? && account_managements.present?
  end

  def should_have_design_totaliser?
    for_my? && designs.present?
  end

  def account_managements
    @account_managements ||= project.account_managements
  end

  def designs
    @designs ||= project.designs
  end

  def job_specifications
    @job_specifications ||= project.job_specifications
  end

  def grouped_labour_items
    labour_items.group_by(&:name)
  end

  def labour_items
    @labour_items ||= project.labour_items
  end

  def mileages
    @mileages ||= project.mileages
  end

  def grouped_product_items
    product_items.group_by(&:name)
  end

  def product_items
    @product_items ||= project.product_items
  end

  def grouped_supporting_product_items
    supporting_product_items.group_by(&:name)
  end

  def supporting_product_items
    @supporting_product_items ||= project.supporting_product_items
  end

  def for_my?
    for_my == true
  end
end
