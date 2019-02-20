class Gamble < ApplicationRecord
  belongs_to :player
  belongs_to :round

  enum color: { green: 1, red: 2, black: 3 }
end
