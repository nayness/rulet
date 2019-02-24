class Player < ApplicationRecord
  include RoundCommons

  has_many :gambles
  has_many :rounds, through: :gambles

  validates :name, presence: true
  validates :email, presence: true

  scope :random_players, ->{ Player.offset(rand(Player.count) - 6).limit(6) }

  def bet_percentage(week_weather)
    return 0 if cash <= 0
    if cash <=1000
      100
    else
      week_weather.max_temperature > 19 ? rand(3..7)/100.to_f : rand(8..15)/100.to_f
    end
  end

  def gamble_color(round_id)
    color = gambles.find_by(round_id: round_id).color
    color_hex(color)
  end

end
