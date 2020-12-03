# == Schema Information
#
# Table name: envisage_invoices
#
#  id         :integer          not null, primary key
#  amount     :decimal(10, 2)   not null
#  name       :string           not null
#  paid       :boolean          default(FALSE), not null
#  percentage :integer          not null
#  vat        :decimal(10, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :integer
#
# Indexes
#
#  index_envisage_invoices_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class Envisage::Invoice < ActiveRecord::Base
  self.table_name = "envisage_invoices"
  
  belongs_to :project
  has_one :customer, through: :project
  has_one :brand, through: :project

  scope :order_by_latest, -> { order(updated_at: :desc) }
  scope :paid, -> { where(paid: true) }
  scope :unpaid, -> { where(paid: false) }

  delegate :name, to: :customer, prefix: true
  delegate :name, to: :project, prefix: true

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true
  validates :percentage, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :project, presence: true
  validates :vat, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total_inc_vat
    amount + vat
  end

  def unpaid?
    !paid?
  end

  def number
    "ENVS#{ id }"
  end
end
