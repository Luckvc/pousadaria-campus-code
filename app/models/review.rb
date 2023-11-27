class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :reservation
  validates :score, presence: true
end
