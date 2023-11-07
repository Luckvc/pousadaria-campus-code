class CustomDate < ApplicationRecord
  belongs_to :room
  validates :begin, :end, :price_cents, presence:true

  def range_overlap?(range1_begin, range1_end, range2_begin, range2_end)
    !(range1_end < range2_begin || range1_begin > range2_end)
  end
end
