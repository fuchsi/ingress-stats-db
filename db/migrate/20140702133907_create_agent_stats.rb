class CreateAgentStats < ActiveRecord::Migration
  def change
    create_table :agent_stats do |t|
      t.references :user, index: true
      t.integer :ap
      t.integer :level

      t.timestamps
    end
  end
end
