class Gamble < ApplicationRecord
  belongs_to :player

  def gamble(cash)
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
