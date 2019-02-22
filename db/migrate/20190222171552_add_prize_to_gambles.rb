class AddPrizeToGambles < ActiveRecord::Migration[5.2]
  def change
    add_column :gambles, :prize, :float
  end
end
