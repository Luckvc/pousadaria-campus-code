class Inn < ApplicationRecord
  belongs_to :address
  belongs_to :user, inverse_of: :inn
  accepts_nested_attributes_for :address
end
