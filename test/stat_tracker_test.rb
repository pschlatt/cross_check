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
    @tracker_2 = StatTracker.from_csv(locations_2)

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
    assert_equal 67.0, @tracker.percentage_home_wins
  end

  def test_percent_away_wins_can_be_calculated
    assert_equal 0.33, @tracker.percentage_visitor_wins
  end

  def test_average_goals_by_season_can_be_calculated

    expected = {"20122013"=>5.0}
    assert_equal expected, @tracker_2.average_goals_by_season
  end

  def test_team_name_from_ID
    assert_equal "New Jersey Devils", @tracker.name_from_id("1")
    assert_equal "Vancouver Canucks", @tracker.name_from_id("23")
    assert_equal "Los Angeles Kings", @tracker.name_from_id("26")
  end

  def best_offense_can_be_calculated

    assert_equal "New Jersey Devils", @tracker_2.best_offense
  end

  def test_number_of_games_by_team_name_can_be_calculated
    assert_equal 80, @tracker_2.number_of_games_by_team("New Jersey Devils")
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>3}
    assert_equal expected, @tracker_2.count_of_games_by_season
  end

  def test_best_offense
    assert_equal "j", @tracker.best_offense
  end

  def test_count_of_teams
    assert_equal 4, @tracker.count_of_teams
  end

  def test_worst_offense
    assert_equal "j", @tracker.worst_offense
  end

  def test_average_goals_per_game
    assert_equal 5.0, @tracker.average_goals_per_game
  end

  def test_best_season
    assert_equal "20122013", @tracker.best_season("3")
  end

  def test_worst_season
    assert_equal "20122013", @tracker.worst_season("6")
  end

  def test_team_info
    expected = {}
    assert_equal expected, @tracker.team_info("6")
  end

  def test_average_win_percentage
    assert_equal 1.0, @tracker.average_win_percentage("6")
  end

  def test_most_goals_scored
    assert_equal 2, @tracker.most_goals_scored("3")
  end

  def test_fewest_goals_scored
    assert_equal 1, @tracker.fewest_goals_scored("3")
  end

  def test_games_length
    assert_equal 3, @tracker.game.length
  end

end
