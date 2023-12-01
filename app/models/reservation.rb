class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :customer
  before_create :generate_code
  validates :check_in_date, :check_out_date, :guests, presence: true
  enum status: { confirmed: 2, ongoing:5, completed:7, cancelled:9}
  has_one :review
  has_many :consumables
  has_many :additional_guests

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
