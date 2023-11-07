class CustomDatesController < ApplicationController
  def new
    @room = Room.find(params[:room_id])
    @custom_date = @room.custom_dates.build()
  end
end





