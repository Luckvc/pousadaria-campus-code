class Room < ApplicationRecord
  belongs_to :inn
  has_many :custom_dates

  validates :number, :description, :capacity, :double_beds, :single_beds, :price_cents, :bathrooms, presence:true
  
end
