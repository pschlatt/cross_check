class Team
  attr_reader :team_id,
              :franchiseId,
              :shortName,
              :teamName,
              :abbreviation,
              :link

  def initialize(team_id, franchiseId, shortName, teamName, abbreviation, link)
    @team_id = team_id
    @franchiseId = franchiseId
    @shortName = shortName
    @teamName = teamName
    @abbreviation = abbreviation
    @link = link

  end

end
