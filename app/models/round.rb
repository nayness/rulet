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
      player = gamble.player
      if gamble.color == color && color == 1
        player.cash += gamble.amount * 15
      else
        player.cash += gamble.amount * 2
      end
      player.save
    end
  end

  def winners
    gambles.where(color: color)
  end

  def weekly_weather
    WeeklyWeather.last
  end

  def color_hex
    case color
    when 1
      '#28a745'
    when 2
      '#dc3545'
    when 3
      '#343a40'
    else
      '#E2E2E2'
    end
  end

end
