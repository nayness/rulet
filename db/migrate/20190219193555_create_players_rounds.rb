class CreatePlayersRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :players_rounds do |t|
      t.integer :player_id
      t.integer :round_id

      t.timestamps
    end
  end
end
