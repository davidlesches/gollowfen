class StatsController < ApplicationController

  def index
    gon.term_chart    = TermChart.new(current_user).data
    gon.history_chart = HistoryChart.new(current_user).data
  end

end