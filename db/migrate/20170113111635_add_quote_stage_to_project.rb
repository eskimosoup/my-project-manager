class AddQuoteStageToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :quote_stage, index: true, foreign_key: true
  end
end
