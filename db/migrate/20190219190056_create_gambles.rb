class CreateGambles < ActiveRecord::Migration[5.2]
  def change
    create_table :gambles do |t|
      t.integer :player_id
      t.integer :round_id
      t.float :percentage
      t.float :amount
      t.integer :color

      t.timestamps
    end
  end
end
