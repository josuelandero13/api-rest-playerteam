class CreatePlayerSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :player_skills do |t|
      t.string :sikill_name, null: false
      t.integer :value, null: false
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
