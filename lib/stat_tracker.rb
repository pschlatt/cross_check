require 'csv'
require 'pry'
require './modules/setup_and_fileio/csv_processor'







class StatTracker
  include CsvProcessor
  # include TotalScore
  attr_reader :games,
              :teams,
              :game_teams_stats
  def initialize(boolean = false)
    @games = game_processor(boolean)
    @teams = team_processor(boolean)
    @game_teams_stats = game_team_stat_processor(boolean)
  end 
  # #fixture file
  # def highest_total_score
  #   highest_total
  # end
  #
  # def lowest_total_score
  #   lowest_total
  # end
end
