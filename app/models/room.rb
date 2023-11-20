class Room < ApplicationRecord
  belongs_to :inn
  has_many :custom_dates
  has_many :pre_reservations
  has_many :reservations

  validates :number, :description, :capacity, :double_beds, :single_beds, :price_cents, :bathrooms, presence:true
  
end
