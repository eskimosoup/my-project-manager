class MultipleProductAddition
  include ActiveModel::Model
  attr_reader :product_items
  attr_accessor :print_job_id

  validates :print_job_id, presence: true

  def initialize(attributes = {})
    # This is here to ensure product_items_attributes are called
    attributes.merge!({ product_items_attributes: {} }){|k, v1, v2| v1 }
    super
  end

  def save
    ActiveRecord::Base.transaction do
      product_items.select{|x| x.area > 0.0 }.each do |product_item|
        product_item.save!
      end
    end
  end

  def product_items_attributes=(attrs)
    @product_items ||= []
    products.each do |product|
      product_item_attrs = find_attrs_for_product(attrs: attrs, id: product.id)
      product_item = ProductItem.new(product_item_attrs)
      @product_items.push(product_item)
    end
  end

  def products
    Product.all
  end

  def print_job
    @print_job ||= PrintJob.find(print_job_id)
  end

  def find_attrs_for_product(attrs: {}, id:)
    attrs.values.detect{|x| x[:product_id].to_i == id } || default_product_item(id)
  end

  private

  def default_product_item(product_id)
    { product_id: product_id, area: 0.0, print_job_id: print_job_id }
  end

end
