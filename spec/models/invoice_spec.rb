require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "associations", :association do
    it { should belong_to(:project) }
    it { should have_one(:customer).through(:project) }
  end

  it { should delegate_method(:name).to(:customer).with_prefix }
  it { should delegate_method(:name).to(:project).with_prefix }
end
