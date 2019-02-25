class Gamble < ApplicationRecord
  include RoundCommons

  belongs_to :player
  belongs_to :round

  enum color: [:green, :red, :black ]

end
