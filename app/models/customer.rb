class Customer < ActiveRecord::Base
  include Filterable

  has_one :main_contact, ->{ order(made_main_contact_at: :desc).first }, class_name: 'Contact'
  has_many :addresses
  has_many :contacts
  has_many :projects

  validates :name, presence: true, uniqueness: true
  validates :credit_limit, numericality: { greater_than_or_equal_to: 0.0 }
  validates :amount_on_credit, numericality: { less_than_or_equal_to: :credit_limit }

  scope :alphabetical, -> { order(name: :asc) }
  scope :name_search, ->(keywords) { where('customers.name ILIKE ?', "%#{keywords}%").alphabetical if keywords.present? }
  scope :project_type, ->(value) {
    joins(:projects).where(projects: { status: value }).group("customers.id").having("count(projects.id) >= ?", 1)
  }
end
