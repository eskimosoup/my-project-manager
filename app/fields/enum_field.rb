require "administrate/fields/base"

class EnumField < Administrate::Field::Base
  def to_s
    data
  end

  def select_options
    Brand.brand_types.keys
  end
end
