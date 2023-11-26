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

  def calculate_total
    if self.check_in_date.present? && self.check_out_date.present?
      cd_matches = []
      self.total = 0

      self.room.custom_dates.each do |cd|
        if range_overlap(self.check_in_date, self.check_out_date, cd.begin, cd.end)
          cd_matches << cd
        end
      end

      (self.check_in_date...self.check_out_date).each do |day|
        price = self.room.price
        cd_matches.each do |cd|
          (cd.begin..cd.end).each do |cd_day|
            price = cd.price if cd_day == day
          end
        end
        self.total += price
      end
    end
  end

  def range_overlap(rangea_begin, rangea_end, rangeb_begin, rangeb_end)
    if !(rangea_end < rangeb_begin || rangea_begin > rangeb_end)
      self.errors.add(:check_in_date, "não disponível")
    end
  end

end
