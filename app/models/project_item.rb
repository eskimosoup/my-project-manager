class ProjectItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :project
end
