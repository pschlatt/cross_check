require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'csv'

class StatTrackerTest < Minitest::Test
  def test_it_exists
    # game_path = CSV.read('./data/game.csv')
    # team_path = CSV.read('./data/team_info.csv')
    # game_teams_path = CSV.read('./data/game_teams_stats.csv')
    #
    # locations = {
    #   games: game_path,
    #   teams: team_path,
    #   game_teams: game_teams_path
    # }

    # stat_tracker = StatTracker.new(locations)
    assert_instance_of StatTracker, stat_tracker
  end
end
