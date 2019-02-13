require './modules/setup_and_fileio/csv_processor'
module TotalScore
  include CsvProcessor
  def highest_total
    info = CsvProcessor.games
    max = info.max_by do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
      # game.home_goals + game.away_goals
    end
    max[:home_goals].to_i + max[:away_goals].to_i
  end

  def lowest_total
    info = CsvProcessor.games
    min = info.min_by do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
    min[:home_goals].to_i + min[:away_goals].to_i
  end

end
