class Round < ApplicationRecord
  has_many :gambles
  has_many :players
end
