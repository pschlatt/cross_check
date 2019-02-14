require 'csv'
require 'pry'
require './modules/setup_and_fileio/csv_processor'
require './modules/game_statistics/percent_wins_mod'
require './modules/game_statistics/math_mod'

class StatTracker
  include CsvProcessor
  include PercentWins
  include GameMath
  # include TotalScore
  attr_reader :games,
              :teams,
              :game_teams_stats
  def initialize(boolean = false)
    @games = game_processor(boolean)
    @teams = team_processor(boolean)
    @game_teams_stats = game_team_stat_processor(boolean)
  end

  def highest_total_score
    max = @games.max_by do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
    max.home_goals.to_i + max.away_goals.to_i
  end

  def lowest_total_score
    min = @games.min_by do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
    min.home_goals.to_i + min.away_goals.to_i
  end

  def biggest_blowout
    blowout = @games.max_by do |game|
      sort_and_find_difference(game.home_goals, game.away_goals)
    end
    sort_and_find_difference(blowout.home_goals, blowout.away_goals)
  end

  def percent_home_team_wins
    side = :home
    percent_team_wins(side)
  end

  def percent_away_team_wins
    side = :away
    percent_team_wins(side)
  end

end
