module LeagueData

  def count_of_teams
    @teams.count
  end

  def name_from_id(team_id)
    team_w_id = @teams.find do |team|
      team.team_id == team_id
    end
    team_w_id.teamname
  end

  def home_team_games(games)
    games.count do |game|
      game.home_team_id == team_id
    end
  end

  def visitor_games
    games.count do |game|
      game.away_team_id == team_id
    end
  end

  def total_home_points(games)
    games.sum do |game|
      if team_id == game.home_team_id
        game.home_goals
      else
        0
      end
    end
  end

  def total_away_points(games)
    games.sum do |game|
      if team_id == game.away_team_id
        game.away_goals
      else
        0
      end
    end
  end

  def goals_scored(games)
    total_home_points(games) + total_away_points(games)
  end

  def games_played(games)
    games.find_all do |game|
      game.away_team_id == @team_id || game.home_team_id == @team_id
    end
  end

  def average_goals_scored(games)
    if games_played(games).count != 0
      (goals_scored(games).to.f / games_played(games).count).round(2)
    else
      0
    end
  end

  def goals_against(games)
    games.sum do |game|
      if team_id = game.home_team_id
        game.away_goals
        elseif team_id = game.away_team_id
        game.home_goals
      else
        0
      end
    end
  end

  def best_offense
    best_team = @teams.max_by do |team|
      team.average_goals_scored(@games)
    end
    return best_team.teamname
  end

  def best_defense
    best_defense = @teams.min_by do |team|
      team.average_goals_against(@games)
    end
    return best_defense.teamname
  end

  def worst_offense
    worst_team = @teams.min_by do |team|
      team.average_goals_scored(@games)
    end
    return worst_team.teamname
  end

  def worst_defense
    worst_defense = @teams.max_by do |team|
      team.average_goals_against(@games)
    end
    return worst_defense.teamname
  end

  def highest_scoring_visitor
    highest_scoring_visitor = teams.max_by do |team|
      if team.visitor_games(games) != 0
        team.total_away_points(games).to_f / team.visitor_games(games)
      else
        0
      end
    end
    highest_score_away_team.teamname
  end

  def lowest_scoring_visitor
    lowest_scoring_visitor = teams.min_by do |team|
      if team.visitor_games(games) != 0
        team.total_away_points(games).to_f / team.visitor_games(games)
      else
        0
      end
    end
    lowest_scoring_visitor.teamname
  end

  def highest_scoring_home_team
    highest_scoring_home_team = teams.max_by do |team|
      if team.home_team_games(games) != 0
        team.total_home_points(games).to_f / team.home_team_games(games)
      else
        0
      end
    end
    highest_scoring_home_team.teamname
  end

  def lowest_scoring_home_team
    lowest_scoring_home_team = teams.max_by do |team|
      if team.home_team_games(games) != 0
        team.total_home_points(games).to_f / team.home_team_games(games)
      else
        100
      end
    end
    lowest_scoring_home_team.teamname
  end

  def winningest_team
    winningest_team = @teams.max_by do |team|
      team.number_of_games_won(games).to_f / team.games_played(games).count
    end
    team_with_highest_win_percentage.teamname
  end

  def best_fans
    best_fans = @teams.max_by do |team|
      (team.home_win_percentage - team.away_win_percentage)
    end
    best_fans.teamname
  end

  def worst_fans
    worst_fans = @teams.select do |team|
      team.away_win_percentage > team.home_win_percentage
    end
    worst_fans.map do |team|
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
