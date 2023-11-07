class Address < ApplicationRecord
  has_one :inn
  validates :street, :number, :neighborhood, :city, :state, :cep, presence:true

  def full_address
    "#{street}, #{number} - #{neighborhood}, #{city} - #{state}"
  end
end
