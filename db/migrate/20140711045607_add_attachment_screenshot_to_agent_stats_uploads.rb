class AddAttachmentScreenshotToAgentStatsUploads < ActiveRecord::Migration
  def self.up
    change_table :agent_stats_uploads do |t|
      t.attachment :screenshot
    end
  end

  def self.down
    remove_attachment :agent_stats_uploads, :screenshot
  end
end
