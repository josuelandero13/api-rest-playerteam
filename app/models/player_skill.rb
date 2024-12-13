class PlayerSkill < ApplicationRecord
  belongs_to :player

  validates :skill_name, inclusion: {
      in: %w[attack defense speed strength stamina],
      message: "Invalid value for skill_name: %{value}"
    }
end
