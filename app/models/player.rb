class Player < ApplicationRecord
  has_many :player_leagues, dependent: :delete_all
  has_many :leagues, through: :player_leagues, dependent: :delete_all
end
