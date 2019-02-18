require './test/test_helper'

class StatTrackerTest < Minitest::Test

  def setup
    @tracker = StatTracker.new(:game_sample, :team_info_sample, :game_team_stats_sample)
    @tracker_2 = StatTracker.new(:game_sample_mk, :team_info_sample, :game_team_stats_sample_mk)

  end

  def test_it_exists
    tracker_inst = StatTracker.new
    assert_instance_of StatTracker, tracker_inst
  end

  def test_game_objects_are_created_on_init
    assert_equal 3, @tracker.games.count
    assert @tracker.games.all?{|game| game.class == Game}
  end

  def test_team_objects_are_created_on_init
    assert_equal 3, @tracker.teams.count
    assert @tracker.teams.all?{|team| team.class == Team}
  end

  def test_game_teams_stats_objects_are_created_on_init
    assert_equal 3, @tracker.game_team_stats.count
    assert @tracker.game_team_stats.all?{|obj| obj.class == GameTeam}
  end

  def test_highest_total_score_can_be_calculated
    assert_equal 7, @tracker.highest_total_score
  end

  def test_lowest_total_score_can_be_calculated
    assert_equal 3, @tracker.lowest_total_score
  end

  def test_biggest_blowout_can_be_calculated
    assert_equal 3, @tracker.biggest_blowout
  end

  def test_sort_and_find_difference
    assert_equal 21, @tracker.sort_and_find_difference(1,22)
  end

  def test_percent_home_wins_can_be_calculated
    assert_equal 66.67, @tracker.percent_home_team_wins
  end

  def test_percent_away_wins_can_be_calculated
    assert_equal 33.33, @tracker.percent_away_team_wins
  end

  def test_average_goals_by_season_can_be_calculated
    expected = {"20122013"=>4.68, "20172018"=>5.5}
    assert_equal expected, @tracker_2.average_goals_by_season
  end

  def test_team_name_from_ID
    assert_equal "New Jersey Devils", @tracker.name_from_id("1")
  end

  def best_offense_can_be_calculated
    assert_equal "New Jersey Devils", @tracker_2.best_offense
  end

  def test_number_of_games_by_team_name_can_be_calculated
    skip
    assert_equal 80, @tracker_2.number_of_games_by_team("New Jersey Devils")
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>22,
                "20172018"=>2 }
    assert_equal expected, @tracker_2.games_by_season
  end
end
