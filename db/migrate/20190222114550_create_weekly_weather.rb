class CreateWeeklyWeather < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_weathers do |t|
      t.string :description
      t.integer :max_temperature
      t.integer :min_temperature
      t.string :icon
      t.timestamps
    end
  end
end
