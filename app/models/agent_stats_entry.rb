class AgentStatsEntry < ActiveRecord::Base
  belongs_to :stat

  def display_name
    StatsHelper::KEYWORDS[name.to_sym]
  end

  def unit
    case name
      when 'discovery_2', 'building_6', 'building_7'
        unit = 'XM'
      when 'building_5', 'health_0'
        unit = 'km'
      when 'defense_0', 'defense_1', 'defense_3'
        unit = 'days'
      when 'defense_2'
        unit = 'km-days'
      when 'defense_4'
        unit = 'MU-days'
      else
        unit = ''
    end

    return unit
  end
end
