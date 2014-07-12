class ImportController < ApplicationController
  before_filter :require_login
  Time::DATE_FORMATS[:time_long] = '%H:%M:%S'

  # GET /import
  def index

  end

  # POST /import
  def import
    if params[:id].to_i > 0
      require 'tesseract'

      e = Tesseract::Engine.new { |e|
        e.path     = Config.tesseract.prefix
        e.language = :eng
      }

      @agent_stats = current_user.agent_stats.find(params[:id])

      if @agent_stats
        text = ''
        @agent_stats.agent_stats_uploads.each do |upload|
          begin
            file = upload.screenshot.path
            text += e.text_for(file).strip
          rescue ArgumentError
            flash.now.alert = t('messages.upload.failure')
          end
        end

        import_date = DateTime.parse("#{params[:date]} #{params[:time]}")
        import_name = params[:name]
        import_name = import_date.to_s(:db) if import_name == ''

        @ap = 0
        @level = 0
        @stats = {}

        text.split("\n").each do |line|
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


        @agent_stats.level = @level
        @agent_stats.ap = @ap
        @agent_stats.name = import_name
        @agent_stats.import_date = import_date

        if @agent_stats.save
          @stats.each do |name, value|
            @agent_stats.agent_stats_entries.create(name: name, value: value)
          end
        end
      else
        flash.now.alert = t('messages.upload.failure')
        render 'index'
      end
    else
      flash.now.alert = t('messages.upload.failure')
      render 'index'
    end
  end

  # POST /upload
  # POST /upload.json
  def upload
    if params[:id] && params[:id].to_i > 0
      @agent_stats = current_user.agent_stats.find(params[:id])
      pos = @agent_stats.agent_stats_uploads.maximum(:pos)
      pos += 1
    else
      import_date = DateTime.current
      import_name = import_date.to_s(:db)

      @agent_stats = AgentStat.new
      @agent_stats.user = current_user
      @agent_stats.name = import_name
      @agent_stats.import_date = import_date
      @agent_stats.save
      pos = 0
    end

    @upload = @agent_stats.agent_stats_uploads.create(pos: pos, screenshot: params[:screenshot])
  end
end
