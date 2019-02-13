require 'csv'
require 'pry'
require './lib/csv_processor'
require './lib/total_score_mod'


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
