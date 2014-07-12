module StatsHelper
  KEYWORDS = {
      discovery_0: 'Unique Portals Visited',
      discovery_1: 'Portals Discovered',
      discovery_2: 'XM Collected',

      building_0:  'Hacks',
      building_1:  'Resonators Deployed',
      building_2:  'Links Created',
      building_3:  'Control Fields Created',
      building_4:  'Mind Units Captured',
      building_5:  'Longest Link Ever Created',
      building_6:  'Largest Control Field',
      building_7:  'XM Recharged',
      building_8:  'Portals Captured',
      building_9:  'Unique Portals Captured',

      combat_0:    'Resonators Destroyed',
      combat_1:    'Portals Neutralized',
      combat_2:    'Enemy Links Destroyed',
      combat_3:    'Enemy Control Fields Destroyed',

      health_0:    'Distance Walked',

      defense_0:   'Max Time Portal Held',
      defense_1:   'Max Time Link Maintained',
      defense_2:   'Max Link Length x Days',
      defense_3:   'Max Time Field Held',
      defense_4:   'Largest Field MUs x Days',
  }

  def format_number_color(n, unit = '')
    number = number_with_delimiter(n)

    if n > 0
      return "<span class=\"number-pos\">#{number} #{unit}</span>"
    end

    "<span class=\"number-neg\">#{number} #{unit}</span>"
  end

  def format_percent(n)
    number = number_to_percentage(n)

    if n > 0
      return "<span class=\"number-pos\">#{number}</span>"
    end

    "<span class=\"number-neg\">#{number}</span>"
  end
end
