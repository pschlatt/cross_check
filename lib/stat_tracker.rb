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
              :game_team_stats

  def initialize(path_1 = :game, path_2 = :team_info, path_3 = :game_team_stats)
    @games = stat_processor(path_1)
    @teams = stat_processor(path_2)
    @game_team_stats = stat_processor(path_3)
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
