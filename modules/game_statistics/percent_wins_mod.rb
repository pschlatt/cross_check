module PercentWins
  def percent_team_wins(side)
    team = {home: 'home win', away:'away win'}
    wins = @game.select do |game|
    game.outcome.include?("#{team[side]}")
    end
    percent_wins = (wins.length/@game.length.to_f)*100
    percent_wins.round(2)
  end

end
