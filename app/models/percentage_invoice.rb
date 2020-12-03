# == Schema Information
#
# Table name: invoices
#
#  id                        :integer          not null, primary key
#  amount                    :decimal(10, 2)   not null
#  due_date                  :date             not null
#  name                      :string           not null
#  non_vat_items_description :text
#  non_vat_items_total       :decimal(10, 2)
#  paid                      :boolean          default(FALSE), not null
#  percentage                :integer
#  slug                      :string
#  type                      :string           default("PercentageInvoice")
#  vat                       :decimal(10, 2)   default(0.0)
#  vat_items_description     :text
#  vat_items_total           :decimal(10, 2)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  project_id                :integer          not null
#  stripe_charge_id          :string
#
# Indexes
#
#  index_invoices_on_project_id        (project_id)
#  index_invoices_on_slug              (slug) UNIQUE
#  index_invoices_on_stripe_charge_id  (stripe_charge_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id) ON DELETE => cascade
#
class PercentageInvoice < Invoice
end
