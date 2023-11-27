class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :customer
  before_create :generate_code
  validates :check_in_date, :check_out_date, :guests, presence: true
  enum status: { confirmed: 2, ongoing:5, completed:7, cancelled:9}

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def range_overlap(rangea_begin, rangea_end, rangeb_begin, rangeb_end)
    if !(rangea_end < rangeb_begin || rangea_begin > rangeb_end)
      self.errors.add(:check_in_date, "não disponível")
    end
  end

end
