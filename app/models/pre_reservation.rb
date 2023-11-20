class PreReservation < ApplicationRecord
  belongs_to :room

  validates :check_in_date, :check_out_date, :guests, presence: true
  validates :check_out_date, comparison: { greater_than: :check_in_date}
  validate :valid_dates, :available_dates, :valid_guests

  before_save :calculate_total

  private 

  def calculate_total
    if self.check_in_date.present? && self.check_out_date.present?
      cd_matches = []
      self.total = 0

      self.room.custom_dates.each do |cd|
        if range_overlap(self.check_in_date, self.check_out_date, cd.begin, cd.end)
          cd_matches << cd
        end
      end

      (self.check_in_date.to_date...self.check_out_date.to_date).each do |day|
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
    if self.check_in_date.present? && self.check_out_date.present? && self.check_in_date < Date.today
      self.errors.add(:check_in_date, " deve ser futura.")
    end
  end

  def available_dates
    if self.check_in_date.present? && self.check_out_date.present?
      self.room.reservations.each do |res|
        range_overlap(self.check_in_date, self.check_out_date, res.check_in_date, res.check_out_date)
      end
    end
  end

  def range_overlap(rangea_begin, rangea_end, rangeb_begin, rangeb_end)
    if !(rangea_end < rangeb_begin || rangea_begin > rangeb_end)
      self.errors.add(:check_in_date, "não disponível")
    end
  end

  def valid_guests
    if self.guests > self.room.capacity
      self.errors.add(:guests, " deve ser menor que a capacidade do quarto.")
    end
  end
end