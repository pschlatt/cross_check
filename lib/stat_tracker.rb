require 'csv'
require 'pry'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'
require_relative '../modules/game_statistics/math_mod'
require_relative '../modules/game_statistics/percent_wins_mod'
require_relative '../modules/league_data/league_mod'


# require_relative ‘./game_stats’
# require_relative ‘./league_stats’
# require_relative ‘./team_stats’
# require_relative ‘./season_stats’

class StatTracker
  # include GamerStats
  # include LeagueStats
  # include TeamStats
  # include SeasonStats
  # include CsvProcessor
  # include LeagueData
  include GameMath
  include PercentWins
  include GameMath

  attr_reader :game, :team, :game_teams

  def initialize(game, team, game_teams)
    @game       = game
    @team       = team
    @game_teams = game_teams
  end


  def self.from_csv(locations)
    game       = game_data(locations[:games])
    team       = team_data(locations[:teams])
    game_teams = game_teams_data(locations[:game_teams])
    StatTracker.new(game, team, game_teams)
  end

  def self.game_data(game_file)
    game = []
    # binding.pry
    csv = CSV.read(game_file)

    csv.each do |row|
      game << Game.new(*row)
    end

    game.shift
    game
    # game = []
    # CSV.foreach(game_file, headers: true, header_converters: :symbols) do |row|
    #   game << Game.new(row)
    # end
    # game # not sure on multiple returns, refactor
  end

  def self.team_data(team_file)
    team = []
    # binding.pry
    csv = CSV.read(team_file)

    csv.each do |row|
      team << Team.new(*row)
    end

    team.shift
    team
    # CSV.foreach(team_file, headers: true, header_converters: :symbols) do |row|
    #   team << Team.new(row)
    # end
    # return team # not sure on multiple returns, refactor
  end

  def self.game_teams_data(game_teams_file)
    game_teams = []
    # binding.pry
    csv = CSV.read(game_teams_file)

    csv.each do |row|
      game_teams << GameTeam.new(*row)
    end

    game_teams.shift
    game_teams
    # CSV.foreach(game_teams_file, headers: true, header_converters: :symbols) do |row|
    #   binding.pry
    #
    #   game_teams << GameTeams.new(row)
    # end
    # return game_teams# not sure on multiple returns, refactor
  end

  def highest_total_score
    max = @game.max_by do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
    max.home_goals.to_i + max.away_goals.to_i
  end


  def lowest_total_score
    min = @game.min_by do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
    min.home_goals.to_i + min.away_goals.to_i
  end

  def biggest_blowout
    blowout = @game.max_by do |game|
      sort_and_find_difference(game.home_goals, game.away_goals)
    end
    sort_and_find_difference(blowout.home_goals, blowout.away_goals)
  end

  def percentage_home_wins
    side = :home
    percent_team_wins(side)
  end

  def percentage_visitor_wins
    side = :away
    percent_team_wins(side)
  end

  def name_from_id(id)
    team_w_id = @team.find do |team|
      team.team_id == id
      # binding.pry
    end
    # binding.pry
    "#{team_w_id.shortName} #{team_w_id.teamName}"
  end

  def number_of_games_by_team(name)
    games = @game_teams.select do |game|
      id = game.team_id
      team_name_from_id(id) == name
    end
    games.length
  end

  def team_name_from_id(id)
    team = @team.find do |team|
      team.team_id == id
    end
    team.teamName
  end

  def best_offense
    teams_goals = {}
    @game.each do |game|
      teams_goals[team_name_from_id(game.home_team_id)] = 0
      teams_goals[team_name_from_id(game.away_team_id)] = 0
    end
    @game.each do |game|
      teams_goals[team_name_from_id(game.home_team_id)] += game.home_goals.to_i
      teams_goals[team_name_from_id(game.away_team_id)] += game.away_goals.to_i
    end
    teams_goals.each do |key, value|
      teams_goals[key] = (value / number_of_games_by_team(key).to_f).round(3)
    end
    winner = teams_goals.sort_by do |team, avg_goals|
      teams_goals[team]
    end
    winner.last.first
  end
  ##test
  def worst_offense
    teams_goals = {}
    @game.each do |game|
      teams_goals[team_name_from_id(game.home_team_id)] = 0
      teams_goals[team_name_from_id(game.away_team_id)] = 0
    end
    @game.each do |game|
      teams_goals[team_name_from_id(game.home_team_id)] += game.home_goals.to_i
      teams_goals[team_name_from_id(game.away_team_id)] += game.away_goals.to_i
    end
    teams_goals.each do |key, value|
      teams_goals[key] = (value / number_of_games_by_team(key).to_f).round(3)
    end
    winner = teams_goals.sort_by do |team, avg_goals|
      teams_goals[team]
    end
    winner.first.first
  end
  #test
  def average_goals_per_game
    total_goals = @game.inject(0) do |total, game|
      total += game.away_goals.to_i + game.home_goals.to_i
      total
    end
    (total_goals / @game.count.to_f).round(2)
  end
  #test
  def count_of_teams
    teams = @team.map do |team|
      team.team_id
    end
    teams.uniq.count
  end
  #test
  def team_info(team_id)
    team = @team.find {|team| team.team_id == team_id}
    info = {"team_id" => team.team_id,
      "franchise_id" => team.franchiseId,
      "short_name" => team.shortName,
      "team_name" => team.teamName,
      "abbreviation" => team.abbreviation,
      "link" => team.link
    }
  end

  def average_goals_by_season
    goals_by_season = {}
    games_by_season = {}
    @game.each do |game|
      goals_by_season[game.season] = 0
      games_by_season[game.season] = 0
    end
    @game.each do |game|
      goals_by_season[game.season] += (game.away_goals.to_i + game.home_goals.to_i)
    end
    @game.each do |game|
      games_by_season[game.season] += 1
    end
    goals_by_season.each do |season, goals|
      avg_goals = goals / games_by_season[season].to_f
      goals_by_season[season] = avg_goals.round(2)
    end
    goals_by_season
  end

  def best_season(team_id)
    season_win_percent = {}
    games = @game.select do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    # binding.pry
    games.each {|game| season_win_percent[game.season] = 0}
    games.each do |game|
      if game.home_team_id == team_id && game.outcome.include?('home win')
        season_win_percent[game.season] += 1
      if game.away_team_id == team_id && game.outcome.include?('away win')
        season_win_percent[game.season] += 1
      end
    end
    # binding.pry
    season_win_percent.each do |season, wins|
      num_played = games.select{|game| game.season == season}
      season_win_percent[season] = (wins / num_played.count.to_f).round(2)
    end
    # binding.pry
    worst_to_best = season_win_percent.sort_by do |season, win_per|
      win_per
    end
    # binding.pry
      worst_to_best.last.first
  end
    def count_of_games_by_season
      games_by_season = {}
      @game.each do |game|
        games_by_season[game.season] = 0
      end
      @game.each do |game|
        games_by_season[game.season] += 1
      end
      games_by_season
      # binding.pry
    end
  end
end
