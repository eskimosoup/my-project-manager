class AddQuoteStageToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :quote_stage, index: true, foreign_key: true
    add_column :projects, :quote_stage_updated_at, :datetime
  end
end
