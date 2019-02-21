module LeagueData

  def count_of_teams
    @teams.count
  end

  def name_from_id(team_id)
    team_w_id = @teams.find do |team|
      team.team_id == id
    end
    team_w_id.teamname
  end

def average_goals_scored(games)
  if games_played(games).count != 0
    ((goals_scored(games)).to.f / games_played(games).count).round(2)
  else
    0.0
  end
end

 def best_offense
    best_team = @teams.max_by do |team|
      team.average_goals_scored(@games)
    end
    return best_team.teamname
  end

  def worst_offense
    worst_team = @teams.min_by do |team|
      team.average_goals_scored(@games)
    end
    return worst_team.teamname
  end

  def winningest_team
    team_with_highest_win_percentage = @teams.max_by do |team|
      team.number_of_games_won(games).to_f / team.games_played(games).count
    end
    team_with_highest_win_percentage.teamname
  end

  # I will calculate away win percentage in the game class for the 2 methods below
  def best_fans
    best_fans_team = @teams.max_by do |team|
      team.home_win_percentage - team.away_win_percentage
    end
    best_fans_team.teamname
  end

  def worst_fans
    worst_fans_teams = @teams.select do |team|
      team.away_win_percentage > team.home_win_percentage
    end
    worst_fans_teams.map do |team|
      team.teamname
    end
  end

  def games_won(games)
    games.find_all do |game|
      game.away_team_id == @team_id && game.outcome.include?("away") ||
        game.home_team_id == @team_id && game.outcome.include?("home")
      end
    end

  def games_lost(games)
    games.find_all do |game|
      game.away_team_id == @team_id && game.outcome.include?("home") ||
        game.home_team_id == @team_id && game.outcome.include?("away")
    end
  end

  def number_of_games_won(games)
    games_won(games).count
  end
end

    # I don't think I need the below method

  #   def best_offense
  #    teams_goals = {}
  #    @game.each do |game|
  #      teams_goals[name_from_id(game.home_team_id)] = 0
  #      teams_goals[name_from_id(game.away_team_id)] = 0
  #    end
  #    @game.each do |game|
  #      teams_goals[name_from_id(game.home_team_id)] += game.home_goals.to_i
  #      teams_goals[name_from_id(game.away_team_id)] += game.away_goals.to_i
  #    end
  #    teams_goals.each do |key, value|
  #      teams_goals[key] = (value / number_of_games_by_team(key).to_f).round(3)
  #    end
  #    winner = teams_goals.sort_by do |team, avg_goals|
  #      teams_goals[team]
  #    end
  #    winner.last.first
  #  end
  # end
