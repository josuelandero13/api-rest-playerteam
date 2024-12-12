class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :position, null: false

      t.timestamps
    end
  end
end
