class PreReservation < ApplicationRecord
  belongs_to :room

  validates :checkin_expected_date, :checkout_expected_date, :guests, presence: true
  validates :checkout_expected_date, comparison: { greater_than: :checkin_expected_date}
  validate :valid_dates, :available_dates, :valid_guests

  before_save :calculate_total

  private 

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

  def valid_dates
    if self.checkin_expected_date.present? && self.checkout_expected_date.present? && self.checkin_expected_date < Date.today
      self.errors.add(:checkin_expected_date, " deve ser futura.")
    end
  end

  def available_dates
    if self.checkin_expected_date.present? && self.checkout_expected_date.present?
      self.room.reservations.each do |res|
        range_overlap(self.checkin_expected_date, self.checkout_expected_date, res.checkin_expected_date, res.checkout_expected_date)
      end
    end
  end

  def range_overlap(rangea_begin, rangea_end, rangeb_begin, rangeb_end)
    if !(rangea_end < rangeb_begin || rangea_begin > rangeb_end)
      self.errors.add(:checkin_expected_date, "não disponível")
    end
  end

  def valid_guests
    if self.guests > self.room.capacity
      self.errors.add(:guests, " deve ser menor que a capacidade do quarto.")
    end
  end
end