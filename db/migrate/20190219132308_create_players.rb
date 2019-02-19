class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.float :cash, null: false, default: 10000

      t.timestamps
    end
  end
end
