class Envisage::Invoice < ActiveRecord::Base
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
