class League < ApplicationRecord
  belongs_to :country
  belongs_to :type
end
