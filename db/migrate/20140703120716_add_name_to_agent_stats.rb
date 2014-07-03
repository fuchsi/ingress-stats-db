class AddNameToAgentStats < ActiveRecord::Migration
  def change
    add_column :agent_stats, :name, :string
  end
end
