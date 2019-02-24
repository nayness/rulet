class Round < ApplicationRecord
  include RoundCommons

  has_many :gambles
  has_many :players, through: :gambles

  scope :winners, -> { players.where(color: color)}

  COLORS = [[1,2],[2,49],[3,49]].freeze

  enum color: [:green, :red, :black]

  def total_bet
    gambles.sum(:amount)
  end

  def wins
    gambles.each do |gamble|
      if gamble.color == color && color == 1
        gamble.prize = gamble.player.cash + gamble.amount * 15
      else
        gamble.prize = gamble.player.cash + gamble.amount * 2
      end
      gamble.save
    end
  end

  def winners
    gambles.where(color: color)
  end

  def weekly_weather
    WeeklyWeather.last
  end

end
