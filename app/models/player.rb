class Player < ApplicationRecord
  has_many :gambles
  has_and_belongs_to_many :rounds

  def gamble
    current = 0
    return if cash <= 0
    if cash <= 1000
      current = cash
    else
      current = cash * rand(8..15)/100.to_f
    end
    current
  end
end
