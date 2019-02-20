class Player < ApplicationRecord
  has_many :gambles
  has_many :rounds, through: :gambles

  scope :random_players, ->{ Player.offset(rand(Player.count) - 6).limit(6) }

  def gamble
    return 0 if cash <= 0
    case cash
    when cash<= 1000
      cash
    else
      cash * rand(8..15)/100.to_f
    end
  end
end
