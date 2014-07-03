class AddImportDateToAgentStats < ActiveRecord::Migration
  def change
    add_column :agent_stats, :import_date, :datetime
    add_index :agent_stats, :import_date
  end
end
