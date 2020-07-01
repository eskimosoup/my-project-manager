class Customer < ActiveRecord::Base
  include Filterable

  has_one :main_contact, ->{ order(made_main_contact_at: :desc).limit(1) }, class_name: 'Contact'

  delegate :email, to: :main_contact, prefix: true, allow_nil: true
  delegate :phone, to: :main_contact, prefix: true, allow_nil: true

  has_many :addresses
  has_many :contacts
  has_many :projects
  has_many :invoices, through: :projects

  validates :name, presence: true, uniqueness: true
  validates :credit_limit, numericality: { greater_than_or_equal_to: 0.0 }
  validates :payment_days, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :amount_on_credit, numericality: { less_than_or_equal_to: :credit_limit }

  scope :alphabetical, -> { order(name: :asc) }
  scope :name_search, ->(keywords) { where('customers.name ILIKE ?', "%#{keywords}%").alphabetical if keywords.present? }
  scope :project_type, lambda { |value|
    joins(:projects).where(projects: { status: value }).group('customers.id').having('count(projects.id) >= ?', 1)
  }

end
