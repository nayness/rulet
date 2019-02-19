class AddGambleToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :gamble, :float
  end
end
