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

  def gamble_color(round_id)
    color = gambles.find_by(round_id: round_id).color
    current_color(color)
  end

  def current_color(color)
    case color
    when 'green'
      '#28a745'
    when 'red'
      '#dc3545'
    when 'black'
      '#343a40'
    else
      '#E2E2E2'
    end
  end
end
