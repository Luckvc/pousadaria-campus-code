class Room < ApplicationRecord
  belongs_to :inn
  has_many :custom_dates
end
