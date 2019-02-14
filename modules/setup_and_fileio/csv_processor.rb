require 'pry'
require './lib/game'
require './lib/team'
require './lib/game_team'
module CsvProcessor
  def game_processor(boolean = false)
    csv = ""
    games = []
    if boolean == true
      csv = CSV.read("./data/game_sample.csv")
    else
      csv = CSV.read("./data/game.csv")
    end
    csv.each do |game|
      games << Game.new(*game)
    end
    games.shift
    games
  end

  def team_processor(boolean = false)
    csv = ""
    teams = []
    if boolean == true
      csv = CSV.read("./data/team_info_sample.csv")
    else
      csv = CSV.read("./data/team_info.csv")
    end
    csv.each do |team|
      teams << Team.new(*team)
    end
    teams.shift
    teams
  end

  def game_team_stat_processor(boolean = false)
    csv = ""
    teams = []
    if boolean == true
      csv = CSV.read("./data/game_team_stats_sample.csv")
    else
      csv = CSV.read("./data/game_teams_stats.csv")
    end
    csv.each do |team|
      teams << GameTeam.new(*team)
    end
    teams.shift
    teams
  end


end

  # def self.info(path)
  #   files = {games: 'game.csv',
  #            teams: 'team_info.csv',
  #            game_stats: 'game_teams_stats.csv',
  #           }
  #   csv_path = CSV.read("./data/#{files[path]}")
  #   info_array = []
  #   csv_path.each do |row|
  #     info_hash = {}
  #     row.each.with_index do |element, index|
  #       element_symbol = csv_path[0][index].to_sym
  #       info_hash[element_symbol] = element
  #     end
  #     info_array << info_hash
  #   end
  #   info_array.shift #.drop
  #   info_array
  # end
  #
  # def self.games
  #   game_info = self.info(:games)
  # end
  #
  # def self.game_stats
  #   game_stats = self.info(:game_stats)
  # end
  #
  # def self.teams
  #   teams = self.info(:teams)
  # end
