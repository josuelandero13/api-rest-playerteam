class TeamBuilderService
  def self.find_best_players(position, main_skill, number_of_players)
    players_with_skill = Player.joins(:player_skills)
                               .where(players: { position: position })
                               .where(player_skills: { skill_name: main_skill })
                               .distinct

    if players_with_skill.empty?
      players_without_specific_skill(position, number_of_players)
    else
      players_with_skill(players_with_skill, main_skill, number_of_players)
    end
  end

  private

  def self.players_without_specific_skill(position, number_of_players)
    players =
      Player.joins(:player_skills).where(players: { position: position }).distinct

    best_players_by_skill_value(players, number_of_players).map do |player|
      highest_skill = player.player_skills.max_by(&:value)

      hash_player_skill(
        player.name, player.position,
        highest_skill&.skill_name,
        highest_skill&.value
      )
    end
  end

  def self.players_with_skill(players_with_skill, main_skill, number_of_players)
    selected_players = players_with_skill.includes(:player_skills)
                                         .order("player_skills.value DESC")
                                         .limit(number_of_players)

    selected_players.map do |player|
      hash_player_skill(
        player.name, player.position,
        main_skill, player.player_skills.pluck(:value)&.first
      )
    end
  end

  def self.best_players_by_skill_value(players, number_of_players)
    players_ordered_by_skill = players.sort_by do |player|
      -player.player_skills.maximum(:value)
    end

    players_ordered_by_skill.take(number_of_players)
  end

  def self.hash_player_skill(player_name, position, skill_name, player_skill_value)
    {
      name: player_name,
      position: position,
      playerSkills: [
        {
          skill_name: skill_name,
          value: player_skill_value
        }
      ]
    }
  end
end
