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

  def test_highest_total_score_can_be_calculated
    tracker = StatTracker.new(true)
    assert_equal 7, tracker.highest_total_score
  end

  def test_lowest_total_score_can_be_calculated
    tracker = StatTracker.new(true)
    assert_equal 3, tracker.lowest_total_score
  end

  def test_biggest_blowout_can_be_calculated
    tracker = StatTracker.new(true)
    assert_equal 3, tracker.biggest_blowout
  end

  def test_sort_and_find_difference
    tracker = StatTracker.new(true)
    assert_equal 21, tracker.sort_and_find_difference(1,22)
  end

  def test_percent_home_wins_can_be_calculated
    tracker = StatTracker.new(true)
    assert_equal 66.67, tracker.percent_home_team_wins
  end

  def test_percent_away_wins_can_be_calculated
    tracker = StatTracker.new(true)
    assert_equal 33.33, tracker.percent_away_team_wins
  end
end
