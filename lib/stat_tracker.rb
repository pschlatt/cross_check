require 'csv'
require 'pry'

class StatTracker

  def initialize
  end

  #fixture file

  def self.games
    self.info(:games)
  end

  def self.teams
    self.info(:teams)
  end

  def self.game_stats
    self.info(:game_stats)
  end


  def self.info(path)
    files = {games: 'game.csv', teams: 'team_info.csv', game_stats: 'game_teams_stats.csv'}
    csv_path = CSV.read("./data/#{files[path]}")
    info_array = []
    csv_path.each do |row|
      info_hash = {}
      row.each.with_index do |element, index|
        element_symbol = csv_path[0][index].to_sym
        info_hash[element_symbol] = element
      end
      info_array << info_hash
    end
    info_array.shift #.drop
    info_array
  end



#   def self.games_info
#     game_path = CSV.read('./data/game.csv')
#     games_info_array = []
#     game_path.each do |row|
#       games_info_hash = {}
#       row.each.with_index do |element, index|
#         element_symbol = game_path[0][index].to_sym
#         games_info_hash[element_symbol] = element
#       end
#       games_info_array << games_info_hash
#     end
#     games_info_array.shift #.drop(1)
#     games_info_array
#   end
#
#   def self.game_teams_stats_info
#     game_team_stats_path = CSV.read('./data/game_teams_stats.csv')
#     game_teams_stats_array = []
#     game_team_stats_path.each do |row|
#       game_teams_stats_hash = {}
#       row.each.with_index do |element, index|
#         element_symbol = game_team_stats_path[0][index].to_sym
#         game_teams_stats_hash[element_symbol] = element
#       end
#       game_teams_stats_array << game_teams_stats_hash
#     end
#     game_teams_stats_array.shift
#     game_teams_stats_array
#   end
#
#   def self.team_info
#     team_info_path = CSV.read('./data/team_info.csv')
#     team_info_array = []
#     team_info_path.each do |row|
#       team_info_hash = {}
#       row.each.with_index do |element, index|
#         element_symbol = team_info_path[0][index].to_sym
#         team_info_hash[element_symbol] = element
#       end
#       team_info_array << team_info_hash
#     end
#     team_info_array.shift
#     team_info_array
#   end

  def highest_total_score
    info = StatTracker.games
    max = info.max_by do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
    max[:home_goals].to_i + max[:away_goals].to_i
  end
  binding.pry
end
