class StatsController < ApplicationController
  before_filter :require_login

  def index
    @stats = current_user.agent_stats.order(import_date: :desc)
  end

  def show
    @stats = current_user.agent_stats.find(params[:id])
  end

  def last
    stats = AgentStat.last_two(current_user)
    stats_diff(stats)
  end

  def compare
    stats = []
    if params.has_key?('second')
      stats.push current_user.agent_stats.find(params[:second])
    end
    if params.has_key?('first')
      stats.push current_user.agent_stats.find(params[:first])
    end
    stats_diff(stats)

    @options = current_user.agent_stats.reverse
  end

  def edit
    @stats = current_user.agent_stats.find(params[:id])
  end

  def update
    @stats = current_user.agent_stats.find(params[:id])

    respond_to do |format|
      if @stats.update(stats_params)
        format.html { redirect_to stats_path(@stats), notice: 'Agent Stats were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stats.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stats = current_user.agent_stats.find(params[:id])
    @stats.delete
    respond_to do |format|
      format.html { redirect_to stats_url }
      format.json { head :no_content }
    end
  end

  private
    def stats_diff(stats)
      if stats.any?
        e1 = stats[0]

        @ap = e1.ap.to_i
        @ap_change = 0
        @ap_change_perc = 0.0

        @level = e1.level.to_i
        @level_change = 0
        @level_change_perc = 0.0

        @entries = Hash.new({})

        e1.agent_stats_entries.each do |entry|
          key = entry.name.to_s
          @entries[key] = {value: entry.value.to_i, change: 0, change_perc: 0.0}
        end

        if stats.many?
          @ap_change = @ap - stats[1].ap.to_i
          @ap_change_perc = ((@ap_change.to_f / stats[1].ap.to_f) * 100).to_f
          @level_change= @level - stats[1].level
          @ap_change_perc_perc = ((@level_change.to_f / stats[1].level.to_f) * 100).to_f

          stats[1].agent_stats_entries.each do |entry|
            key = entry.name.to_s
            @entries[key][:change] = @entries[key][:value] - entry.value.to_i
            @entries[key][:change_perc] = ((@entries[key][:change].to_f / entry.value.to_f) * 100).to_f
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stats_params
      params.require(:agent_stat).permit(:name, :level, :ap, addresses_attributes: [:id, :name, :value])
    end
end
