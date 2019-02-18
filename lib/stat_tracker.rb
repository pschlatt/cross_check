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

  def name_from_id(id)
    team_w_id = @teams.find do |team|
      team.team_id == id
    end
    # binding.pry
    "#{team_w_id.shortName} #{team_w_id.teamName}"
  end

    def number_of_games_by_team(name)
      games = @game_team_stats.select do |game|
        id = game.team_id
        name_from_id(id) == name
      end
      games.length
    end

  def best_offense
    teams_goals = {}
    @games.each do |game|
      teams_goals[name_from_id(game.home_team_id)] = 0
      teams_goals[name_from_id(game.away_team_id)] = 0
    end
    @games.each do |game|
      teams_goals[name_from_id(game.home_team_id)] += game.home_goals.to_i
      teams_goals[name_from_id(game.away_team_id)] += game.away_goals.to_i
    end
    teams_goals.each do |key, value|
      teams_goals[key] = (value / number_of_games_by_team(key).to_f).round(3)
    end
    winner = teams_goals.sort_by do |team, avg_goals|
      teams_goals[team]
    end
    winner.last.first
  end

  def average_goals_by_season
    goals_by_season = {}
    games_by_season = {}
    @games.each do |game|
      goals_by_season[game.season] = 0
      games_by_season[game.season] = 0
    end
    @games.each do |game|
      goals_by_season[game.season] += (game.away_goals.to_i + game.home_goals.to_i)
    end
    @games.each do |game|
      games_by_season[game.season] += 1
    end
    goals_by_season.each do |season, goals|
      avg_goals = goals / games_by_season[season].to_f
      goals_by_season[season] = avg_goals.round(2)
    end
    goals_by_season
  end

  def games_by_season
    games_by_season = {}
    @games.each do |game|
      games_by_season[game.season] = 0
    end
    @games.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
    # binding.pry
  end
end
# binding.pry
