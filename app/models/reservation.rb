class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :customer
  before_validation :generate_code
  before_save :calculate_total
  validates :check_in_date, :check_out_date, :guests, :code, presence: true

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

end
