class Api::TeamController < ApplicationController
  def team_process
    team_requirements = JSON.parse(request.body.read)

    completed_team = team_requirements.each_with_object([]) do |requirement, result|
      position = requirement["position"]
      main_skill = requirement["mainSkill"]
      number_of_players = requirement["numberOfPlayers"]

      players =
        TeamBuilderService.find_best_players(position, main_skill, number_of_players)

      result << validated_players(players, position)
    end

    render json: completed_team
  end

  def validated_players(players, position)
    return players if players.is_a?(Array) && !players.blank?

    { error: "Players not found." }
  end
end
