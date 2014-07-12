class AgentStatsUpload < ActiveRecord::Base
  belongs_to :agent_stat

  has_attached_file :screenshot, {
                    :url => "/uploads/:hash.:extension",
                    :hash_secret => "8bvpty8gf326iq65y5kje906p1qedhqmbt6y1ip9s54xdlrl6qiayvogku2s34f0"
  }
  validates_attachment_content_type :screenshot, :content_type => /\Aimage\/.*\Z/
end
