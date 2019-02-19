class Round < ApplicationRecord
  has_many :gambles
  has_and_belongs_to_many :players
end
