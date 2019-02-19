class AddIndexesToGamble < ActiveRecord::Migration[5.2]
  def change
    add_index :gambles, [:player_id, :round_id], unique: true
  end
end
