class Round < ApplicationRecord
  has_many :gambles
  has_many :players, through: :gambles
end
