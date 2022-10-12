class Country < ApplicationRecord
  validates :name, presence: true
  has_many :leagues, dependent: :delete_all
end
