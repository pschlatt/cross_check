require './test/test_helper'

class StatTrackerTest < Minitest::Test
  def test_it_exists
    stat_tracker = StatTracker.new
    assert_instance_of StatTracker, stat_tracker
  end

  def test_game_objects_are_created_on_init
    tracker = StatTracker.new(true)
    assert_equal 3, tracker.games.count
    assert tracker.games.all?{|game| game.class == Game}
  end

  def test_team_objects_are_created_on_init
    tracker = StatTracker.new(true)
    assert_equal 3, tracker.teams.count
    assert tracker.teams.all?{|team| team.class == Team}
  end

  def test_game_teams_stats_objects_are_created_on_init
    tracker = StatTracker.new(true)
    assert_equal 3, tracker.game_teams_stats.count
    assert tracker.game_teams_stats.all?{|obj| obj.class == GameTeam}
  end
end
