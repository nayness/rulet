class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.integer :color
      t.integer :winner
      t.float :total_amount
      t.integer :state, null: false, default: 0
      t.timestamps
    end
  end
end
