class League < ApplicationRecord
  validates :name, :logo, :season, presence: true
  belongs_to :country
  belongs_to :type
end
