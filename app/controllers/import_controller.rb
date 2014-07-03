class ImportController < ApplicationController
  before_filter :require_login
  Time::DATE_FORMATS[:time_long] = '%H:%M:%S'

  def index

  end

  def import
    if params.has_key?(:screenshot)
      require 'tesseract'

      e = Tesseract::Engine.new { |e|
        e.path     = Config.tesseract.prefix
        e.language = :eng
      }

      text = ''
      params[:screenshot].each do |upload|
        file = upload.open
        text += e.text_for(file).strip
      end

      import_date = DateTime.parse("#{params[:date]} #{params[:time]}")
      import_name = params[:name]
      import_name = import_date.to_s(:db) if import_name == ''

      @ap = 0
      @level = 0
      @stats = {}

      text.split("\n").each do |line|
        puts line
        line.match(/^([0-9,]+) AP/) {|m| @ap=m[1].gsub(/,/,'')}
        line.match(/^LVL\s*(\d+)$/) {|m| @level=m[1]}

        StatsHelper::KEYWORDS.each do |key, value|
          if line.index(value) != nil
            line.match(/([0-9,]+)/) do |m|
              val = m[1].gsub(/,/, '')
              @stats[key] = val
            end
          end
        end
      end

      stats = AgentStat.new
      stats.user = current_user
      stats.level = @level
      stats.ap = @ap
      stats.name = import_name
      stats.import_date = import_date

      if stats.save
        @stats.each do |name, value|
          stats.agent_stats_entries.create(name: name, value: value)
        end
      end
    else
      flash.now.alert = t('messages.upload.failure')
      render 'index'
    end
  end
end
