class Consumable < ApplicationRecord
  validates :description, :price, presence:true
end
