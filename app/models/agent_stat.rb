class AgentStat < ActiveRecord::Base
  belongs_to :user

  has_many :agent_stats_entries

  def self.last_two(user)
    where('user_id = ?', user.id).order(import_date: :desc).limit(2)
  end
end
