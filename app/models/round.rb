class Round < ApplicationRecord
  has_many :gambles
  has_many :players, through: :gambles

  scope :winners, -> { players.where(color: color)}

  COLORS = [[1,2],[2,49],[3,49]].freeze

  def total_bet
    gambles.sum(:amount)
  end

  def wins
    gambles.each do |gamble|
      if player.color == color && color == 1
        player.cash += gamble.amount * 15
      else
        player.cash += gamble.amount * 2
      end
    end
  end

  def winners
    gambles.where(color: color)
  end

end
