module PercentWins
  def percent_team_wins(side)
    team = {home: 'home win', away:'away win'}
    wins = games.select do |game|
    game.outcome.include?("#{team[side]}")
      end
    percent_wins = (wins.length/@games.length.to_f)*100
    percent_wins.round(2)
  end

  def query_by_season(seasonyears)
    season_game = games.select do |game|
      game.season == seasonyears
    end
    season_game
  end

  def goals_adder_upper
    goals = games.sum do |game|
      game.away_goals.to_f.round(2) + game.home_goals.to_f.round(2)
    end
    goals
  end

  

end
