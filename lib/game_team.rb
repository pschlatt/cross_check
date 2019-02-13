class GameTeam
attr_reader :game_id,
             :team_id,
             :hoA,
             :won,
             :settled_in,
             :head_coach,
             :goals,
             :shots,
             :hits,
             :pim,
             :powerPlayOpportunities,
             :powerPlayGoals,
             :faceOffWinPercentage,
             :giveaways,
             :takeaways


def initialize(game_id,
               team_id,
               hoA,
               won,
               settled_in,
               head_coach,
               goals,
               shots,
               hits,
               pim,
               powerPlayOpportunities,
               powerPlayGoals,
               faceOffWinPercentage,
               giveaways,
               takeaways)
        @game_id = game_id
        @team_id = team_id
        @hoA = hoA
        @won = won
        @settled_in = settled_in
        @head_coach = head_coach
        @goals = goals
        @shots = shots
        @hits = hits
        @pim = pim
        @powerPlayOpportunities = powerPlayOpportunities
        @powerPlayGoals = powerPlayGoals
        @faceOffWinPercentage = faceOffWinPercentage
        @giveaways = giveaways
        @takeaways = takeaways
end

end
