class Gamble < ApplicationRecord
  belongs_to :player
  belongs_to :round

  enum color: [:green, :red, :black ]
end
