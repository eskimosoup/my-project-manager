class AddPositionToQuoteStage < ActiveRecord::Migration
  def change
    add_column :quote_stages, :position, :integer
  end
end
