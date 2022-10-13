class Player < ApplicationRecord
  has_many :player_leagues
  has_many :players, through: :player_leagues
end
