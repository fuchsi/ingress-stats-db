class CreateAgentStatsUploads < ActiveRecord::Migration
  def change
    create_table :agent_stats_uploads do |t|
      t.references :agent_stat, index: true
      t.integer :pos

      t.timestamps
    end
    add_index :agent_stats_uploads, :pos
  end
end
