class Player < ApplicationRecord
  has_many :player_skills, dependent: :destroy
  accepts_nested_attributes_for :player_skills

  validates :name, :position, presence: true
  validates :position, inclusion: {
      in: %w[defender midfielder forward],
      message: "Invalid value for position: %{value}"
    }
end
