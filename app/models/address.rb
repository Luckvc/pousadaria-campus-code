class Address < ApplicationRecord
  has_one :inn


  def full_address
    "#{street}, #{number} - #{neighborhood}, #{city} - #{state}"
  end
end
