class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :customer
  before_create :generate_code
  validates :checkin_expected_date, :checkout_expected_date, :guests, presence: true
  enum status: { confirmed: 2, occurring:5, completed:7, cancelled:9}

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def calculate_total
    if self.checkin_expected_date.present? && self.checkout_expected_date.present?
      cd_matches = []
      self.total = 0

      self.room.custom_dates.each do |cd|
        if range_overlap(self.checkin_expected_date, self.checkout_expected_date, cd.begin, cd.end)
          cd_matches << cd
        end
      end

      (self.checkin_expected_date.to_date...self.checkout_expected_date.to_date).each do |day|
        price = self.room.price
        cd_matches.each do |cd|
          (cd.begin.to_date..cd.end.to_date).each do |cd_day|
            price = cd.price if cd_day == day
          end
        end
        self.total += price
      end
    end
  end

  def range_overlap(rangea_begin, rangea_end, rangeb_begin, rangeb_end)
    if !(rangea_end < rangeb_begin || rangea_begin > rangeb_end)
      self.errors.add(:checkin_expected_date, "não disponível")
    end
  end

end
