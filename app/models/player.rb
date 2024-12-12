class Player < ApplicationRecord
  has_many :player_skills

  validates :name, :position, presence: true

  AVAILABLE_POSITIONS = %w[
    defender midfielder forward
  ].freeze
end
