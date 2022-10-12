class Type < ApplicationRecord
  has_many :leagues, dependent: :delete_all
end
