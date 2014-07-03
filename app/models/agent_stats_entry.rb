class AgentStatsEntry < ActiveRecord::Base
  belongs_to :stat

  def display_name
    StatsHelper::KEYWORDS[name.to_sym]
  end
end
