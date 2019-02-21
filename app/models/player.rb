class Player < ApplicationRecord
  has_many :gambles
  has_many :rounds, through: :gambles

  validates :name, presence: true
  validates :email, presence: true

  scope :random_players, ->{ Player.offset(rand(Player.count) - 6).limit(6) }

  def bet_percentage
    return 0 if cash <= 0
    if cash <=1000
      100
    else
      rand(8..15)/100.to_f
    end
  end
end
