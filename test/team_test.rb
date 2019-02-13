require './test/test_helper'

class TeamTest < Minitest::Test

def test_team_exists
  team = Team.new("17",
                  "12",
                  "Detroit",
                  "Red Wings",
                  "DET",
                  "/api/v1/teams/17")
  assert_instance_of Team, team
  end
end
