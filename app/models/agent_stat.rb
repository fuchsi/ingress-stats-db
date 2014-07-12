class AgentStat < ActiveRecord::Base
  belongs_to :user

  has_many :agent_stats_entries, dependent: :destroy
  has_many :agent_stats_uploads, dependent: :destroy

  accepts_nested_attributes_for :agent_stats_entries
  accepts_nested_attributes_for :agent_stats_uploads

  validates_presence_of :import_date, :name, :user_id

  def self.last_two(user)
    where('user_id = ?', user.id).order(import_date: :desc).limit(2)
  end
end
