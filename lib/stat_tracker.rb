require 'csv'
require 'pry'
require './modules/setup_and_fileio/csv_processor'
require './modules/game_statistics/total_score_mod'


class StatTracker
  include CsvProcessor
  include TotalScore

  def initialize

  end
  #fixture file
  def highest_total_score
    highest_total
  end

  def lowest_total_score
    lowest_total
  end
end
