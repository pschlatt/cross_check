require './test/test_helper'

class GameTeamTest < Minitest::Test

  def test_game_team_exists
    game_team = GameTeam.new("2012030311",
                         "5",
                         "home",
                         FALSE,
                         "REG",
                         "Dan Bylsma",
                         0,
                         29,
                         34,
                         28,
                         4,
                         0,
                         33.3,
                         8,
                         9)
    assert_instance_of GameTeam, game_team
  end

end
