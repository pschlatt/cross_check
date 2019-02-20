module GameStats
  def total_score
    @games.map do |game|
      (game.away_goals + game.home_goals)
    end
  end

  def total_score_sum
    total_score.sum
  end

  def total_game_count
    @games.count
  end

  def point_spread
    @games.map. do | game |
      (game.away_goals - game.home_goals).abs # absolute value
  end

  def percent_team_wins(side)
    team = { home: 'home win', away: 'away win' }
    wins = games.select do |game|
      game.outcome.include? team[side].to_s
    end
    percent_wins = (wins.length / @games.length.to_f) * 100
    percent_wins.round(2)
  end

  def highest_total_score
    total_score.max
  end

  def lowest_total_score
    total_score.min
  end

  def biggest_blowout
    point_spread.max
  end

  def percent_home_team_wins
    side = :home
    percent_team_wins(side)
  end

  def percent_visitor_team_wins
    side = :away
    percent_team_wins(side)
  end

  def games_by_season
    games_by_season = {}
    @games.each do |game|
      games_by_season[game.season] = 0
    end
    @games.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    (total_score_sum / total_games.to_f).round(2)
  end
end
