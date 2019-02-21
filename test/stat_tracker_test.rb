require './test/test_helper'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

    game_path_sample = './data/game_sample.csv'
    team_path_sample = './data/team_info_sample.csv'
    game_teams_path_sample = './data/game_team_stats_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    locations_2 = {
      games: game_path_sample,
      teams: team_path_sample,
      game_teams: game_teams_path_sample
    }

    @tracker = StatTracker.from_csv(locations_2)
    # @tracker_2 = StatTracker.new(:game_sample_mk, :team_info_sample, :game_team_stats_sample_mk)

  end

  def test_it_exists
    assert_instance_of StatTracker, @tracker
  end

  def test_game_objects_are_created_on_init
    assert_equal 3, @tracker.game.count
    assert @tracker.game.all?{|game| game.class == Game}
  end

  def test_team_objects_are_created_on_init
    assert_equal 4, @tracker.team.count
    assert @tracker.team.all?{|team| team.class == Team}
  end

  def test_game_teams_stats_objects_are_created_on_init
    assert_equal 3, @tracker.game_teams.count
    assert @tracker.game_teams.all?{|obj| obj.class == GameTeam}
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
    assert_equal 66.67, @tracker.percentage_home_wins
  end

  def test_percent_away_wins_can_be_calculated
    assert_equal 33.33, @tracker.percentage_visitor_wins
  end

  def test_average_goals_by_season_can_be_calculated
    skip
    expected = {"20122013"=>4.68, "20172018"=>5.5}
    assert_equal expected, @tracker_2.average_goals_by_season
  end

  def test_team_name_from_ID
    assert_equal "New Jersey Devils", @tracker.name_from_id("1")
    assert_equal "Vancouver Canucks", @tracker.name_from_id("23")
    assert_equal "Los Angeles Kings", @tracker.name_from_id("26")
  end

  def best_offense_can_be_calculated
    skip
    assert_equal "New Jersey Devils", @tracker_2.best_offense
  end

  def test_number_of_games_by_team_name_can_be_calculated
    skip
    assert_equal 80, @tracker_2.number_of_games_by_team("New Jersey Devils")
  end

  def test_count_of_games_by_season
    skip
    expected = {"20122013"=>22,
                "20172018"=>2 }
    assert_equal expected, @tracker_2.count_of_games_by_season
  end
end
