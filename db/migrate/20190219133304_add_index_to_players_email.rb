class AddIndexToPlayersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :players, :email, unique: true
  end
end
