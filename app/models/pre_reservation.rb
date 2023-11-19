class PreReservation < ApplicationRecord
  belongs_to :room

  validates :check_in_date, :check_out_date, :guests, presence: true
  validates :check_out_date, comparison: { greater_than: :check_in_date}
  validate :valid_dates, :available_dates, :valid_guests, :calculate_total


  private 
  
  def calculate_total
    self.total = (self.check_out_date.to_date - self.check_in_date.to_date) * self.room.price_cents
  end
  
  def valid_dates
    if self.check_in_date.present? && self.check_out_date.present? && self.check_in_date < Date.today
      self.errors.add(:check_in_date, " deve ser futura.")
    end
  end

  def available_dates
  end

  def valid_guests
    if self.guests > self.room.capacity
      self.errors.add(:guests, " deve ser menor que a capacidade do quarto.")
    end
  end
end