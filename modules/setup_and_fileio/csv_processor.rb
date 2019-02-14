require 'pry'
require './lib/game'
require './lib/team'
require './lib/game_team'
module CsvProcessor

  def class_choice(path)
    class_type = ""
    case
    when path.to_s.include?("game_team_stats")
      class_type = GameTeam
    when path.to_s.include?("game")
      class_type = Game
    when path.to_s.include?("team_info")
      class_type = Team
    end
    class_type
  end

  def stat_processor(path)
      paths = {game: "game",
              team_info: "team_info",
              game_team_stats: "game_team_stats",
              game_sample: "game_sample",
              game_sample_2: "game_sample_2",
              game_team_stats_sample: "game_team_stats_sample",
              team_info_sample: "team_info_sample"}
      teams = []
      csv = CSV.read("./data/#{paths[path]}.csv")
      csv.each do |team|
        choice = class_choice(path)
        teams << choice.new(*team)
      end
      teams.shift
      teams
  end

end
