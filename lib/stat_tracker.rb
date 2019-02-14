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
      case
      when game.home_goals.to_i > game.away_goals.to_i
        game.home_goals.to_i - game.away_goals.to_i
      when game.home_goals.to_i < game.away_goals.to_i
        game.away_goals.to_i - game.home_goals.to_i
      when game.home_goals.to_i == game.away_goals.to_i
        0
      end
    end
   case
    when blowout.home_goals.to_i > blowout.away_goals.to_i
      blowout.home_goals.to_i - blowout.away_goals.to_i
    when blowout.home_goals.to_i < blowout.away_goals.to_i
      blowout.away_goals.to_i - blowout.home_goals.to_i
    end 
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
