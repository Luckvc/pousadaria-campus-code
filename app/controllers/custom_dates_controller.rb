class CustomDatesController < ApplicationController

  private 

  def range_overlap?(range1_begin, range1_end, range2_begin, range2_end)
    !(range1_end < range2_begin || range1_begin > range2_end)
  end
end





