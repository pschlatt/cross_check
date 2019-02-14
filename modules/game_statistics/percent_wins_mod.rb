module PercentWins
  def percent_team_wins(side)
    team = {home: 'home win', away:'away win'}
    wins = games.select do |game|
    game.outcome.include?("#{team[side]}")
    end
    percent_wins = (wins.length/@games.length.to_f)*100
    percent_wins.round(2)
  end

end
