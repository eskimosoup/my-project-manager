class Invoice < ActiveRecord::Base
  belongs_to :project
  has_one :customer, through: :project

  delegate :name, to: :customer, prefix: true
  delegate :name, to: :project, prefix: true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      [:customer_name, :project_name, :id]
    ]
  end


end
