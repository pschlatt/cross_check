require 'pry'
module CsvProcessor

  def self.info(path)
    files = {games: 'game.csv',
             teams: 'team_info.csv',
             game_stats: 'game_teams_stats.csv',
            }
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

  def self.games
    game_info = self.info(:games)
  end

  def self.game_stats
    game_stats = self.info(:game_stats)
  end

  def self.teams
    teams = self.info(:teams)
  end


end
