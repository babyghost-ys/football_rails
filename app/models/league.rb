class League < ApplicationRecord
  validates :name, :logo, :season, presence: true
  belongs_to :country
  belongs_to :type

  has_many :player_leagues, dependent: :delete_all
  has_many :players, through: :player_leagues, dependent: :delete_all
end
