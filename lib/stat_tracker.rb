require 'csv'
require 'pry'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'

# require_relative ‘./game_stats’
# require_relative ‘./league_stats’
# require_relative ‘./team_stats’
# require_relative ‘./season_stats’

class StatTracker
 # include GameStats
 # include LeagueStats
 # include TeamStats
 # include SeasonStats

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
end
