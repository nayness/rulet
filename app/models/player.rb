class Player < ApplicationRecord
  has_many :gambles
  has_many :rounds, through: :gambles

  scope :random_players, ->{ Player.offset(rand(Player.count) - 6).limit(6) }

  def bet_percentage
    return 0 if cash <= 0
    if cash <=1000
      100
    else
      rand(8..15)/100.to_f
    end
  end

  def random_color
    weighted_colors = [[1,2],[2,49],[3,49]]
    colors_probabilities = []
    weighted_colors.each do |color|
      color[1].times { colors_probabilities << color[0] }
    end
    colors_probabilities.sample
  end
end
