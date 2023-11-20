class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :customer
  before_validation :generate_code
  validates :check_in_date, :check_out_date, :guests, :code, presence: true

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
