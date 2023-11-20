class CustomDate < ApplicationRecord
  belongs_to :room
  validates :begin, :end, :price, presence:true
  validates :end, comparison: { greater_than: :begin}
  validate :valid_dates, :range_overlap

  private

  def range_overlap()
    if self.room_id.present?
      room = Room.find(self.room_id)
      room.custom_dates.all.each do |cd|
        if !(self.end < cd.begin || self.begin > cd.end)
          self.errors.add(:begin, "não pode haver sobreposição entre preços sazonais")
        end
      end
    end
  end

  def valid_dates
    if self.begin.present? && self.end.present? && self.begin < Date.today
      self.errors.add(:begin, " deve ser futura.")
    end
  end
end
