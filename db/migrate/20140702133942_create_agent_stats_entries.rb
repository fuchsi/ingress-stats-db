class CreateAgentStatsEntries < ActiveRecord::Migration
  def change
    create_table :agent_stats_entries do |t|
      t.references :agent_stat, index: true
      t.string :name
      t.integer :value

      t.timestamps
    end
    add_index :agent_stats_entries, :name
  end
end
